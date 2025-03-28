/* eslint-disable camelcase */
import { prisma } from '@/src/lib/prisma'
// import dayjs from 'dayjs'
import { NextApiRequest, NextApiResponse } from 'next'

export default async function handle(
  req: NextApiRequest,
  res: NextApiResponse,
) {
  if (req.method !== 'GET') {
    return res.status(405).end()
  }

  const username = String(req.query.username)
  const { year, month } = req.query

  if (!year || !month) {
    return res.status(400).json({ message: 'Year or month not specified' })
  }

  const user = await prisma.user.findUnique({
    where: {
      username,
    },
  })

  if (!user) {
    return res.status(400).json({ message: 'User does not exist' })
  }

  const availableWeekDays = await prisma.userTimeInterval.findMany({
    select: {
      week_day: true,
    },
    where: {
      user_Id: user.id,
    },
  })

  const blockedWeekDays = [0, 1, 2, 3, 4, 5, 6].filter((weekday) => {
    return !availableWeekDays.some(
      (availableWeekDays) => availableWeekDays.week_day === weekday,
    )
  })

  const blockedDatesRaw: Array<{ date: number }> = await prisma.$queryRaw`
     SELECT
       EXTRACT(DAY FROM S.DATE) AS date,
       COUNT(S.date) AS amount,
       ((UTI.time_end_in_minutes - UTI.time_start_in_minutes) / 60) AS size
 
     FROM schedullings S
 
     LEFT JOIN user_time_intervals UTI
       ON UTI.week_day = WEEKDAY(DATE_ADD(S.date, INTERVAL 1 DAY))
 
     WHERE S.user_id = ${user.id}
       AND DATE_FORMAT(S.date, "%Y-%m") = ${`${year}-${month}`}
 
     GROUP BY EXTRACT(DAY FROM S.DATE),
       ((UTI.time_end_in_minutes - UTI.time_start_in_minutes) / 60)
 
     HAVING amount >= size
   `

  const blockedDates = blockedDatesRaw.map((item) => Number(item.date))

  console.log(blockedDatesRaw, blockedDates)

  return res.json({ blockedWeekDays, blockedDates })
}

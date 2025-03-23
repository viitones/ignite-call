/* eslint-disable camelcase */
import { prisma } from '@/src/lib/prisma'
import dayjs from 'dayjs'
import { NextApiRequest, NextApiResponse } from 'next'
import { z } from 'zod'

export default async function handle(
  req: NextApiRequest,
  res: NextApiResponse,
) {
  if (req.method !== 'POST') {
    return res.status(405).end()
  }

  const username = String(req.query.username)

  const user = await prisma.user.findUnique({
    where: {
      username,
    },
  })

  if (!user) {
    return res.status(400).json({ message: 'User does not exist' })
  }

  const createSchedulingBody = z.object({
    name: z.string(),
    email: z.string().email(),
    observations: z.string(),
    date: z.string().datetime(),
  })

  const { name, email, observations, date } = createSchedulingBody.parse(
    req.body,
  )

  const schedulingDate = dayjs(date).startOf('hour')

  if (schedulingDate.isBefore(new Date())) {
    return res.status(400).json({ message: 'Invalid date' })
  }

  const conflictScheduling = await prisma.scheduling.findFirst({
    where: {
      user_Id: user.id,
      date: schedulingDate.toDate(),
    },
  })

  if (conflictScheduling) {
    return res.status(400).json({ message: 'Conflict date' })
  }

  await prisma.scheduling.create({
    data: {
      name,
      email,
      observations,
      date: schedulingDate.toDate(),
      user_Id: user.id,
    },
  })

  return res.status(201).end()
}

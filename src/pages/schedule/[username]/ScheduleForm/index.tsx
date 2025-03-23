import { useState } from 'react'
import { CalendarStep } from './CalendarStep'
import { ConfirmStep } from './ConfirmStep'
// import { ConfirmStep } from './ConfirmStep'

export function ScheduleForm() {
  const [selectedDate, setSelectedDate] = useState<Date | null>(null)

  function handleClearSelectedDateTime() {
    setSelectedDate(null)
  }

  if (selectedDate) {
    return (
      <ConfirmStep
        schedulingDate={selectedDate}
        onCancelConfirmation={handleClearSelectedDateTime}
      />
    )
  }

  return <CalendarStep onSelectDateTime={setSelectedDate} />
}

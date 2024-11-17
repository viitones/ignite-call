import {
  Button,
  Checkbox,
  Heading,
  MultiStep,
  Text,
  TextInput,
} from '@ignite-ui/react'

import { ArrowRight } from 'phosphor-react'
import { Container, Header } from '../styles'
import {
  IntervalBox,
  IntervalDay,
  IntervalInputs,
  IntervalItems,
  IntervalsContainer,
} from './styles'

export default function Register() {
  return (
    <Container>
      <Header>
        <Heading as="strong">Quase lá</Heading>
        <Text>
          Defina o intervalo de horários que você está disponível em cada dia da
          semana.
        </Text>

        <MultiStep size={4} currentStep={3} />
      </Header>

      <IntervalBox as="form">
        <IntervalsContainer>
          <IntervalItems>
            <IntervalDay>
              <Checkbox />
              <Text>Segunda Feira</Text>
            </IntervalDay>
            <IntervalInputs>
              <TextInput size="sm" type="time" step={60} />
              <TextInput size="sm" type="time" step={60} />
            </IntervalInputs>
          </IntervalItems>
          <IntervalItems>
            <IntervalDay>
              <Checkbox />
              <Text>Terça Feira</Text>
            </IntervalDay>
            <IntervalInputs>
              <TextInput size="sm" type="time" step={60} />
              <TextInput size="sm" type="time" step={60} />
            </IntervalInputs>
          </IntervalItems>
        </IntervalsContainer>

        <Button>
          Próximo Passo
          <ArrowRight />
        </Button>
      </IntervalBox>
    </Container>
  )
}

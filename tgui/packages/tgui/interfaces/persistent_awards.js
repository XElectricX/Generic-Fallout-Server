import { useBackend } from '../backend';
import { Button, LabeledList, Section } from '../components';
import { Window } from '../layouts';

export const persistent_awards = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <Window resizable>
      <Window.Content scrollable>
        <Section title="Awards">
          <LabeledList>
            <LabeledList.Item label="Recipient">
              {data.character_name}
            </LabeledList.Item>
            <LabeledList.Item label="Issuer">
              {data.issuer_name}
            </LabeledList.Item>
            <LabeledList.Item label="Award Type">
              {data.award_type}
            </LabeledList.Item>
            <LabeledList.Item label="Award Name">
              {data.award_name}
            </LabeledList.Item>
            <LabeledList.Item label="Description">
              {data.description}
            </LabeledList.Item>
            <LabeledList.Item label="Date">
              {data.date}
            </LabeledList.Item>
            <LabeledList.Item label="Remove">
              <Button
                onClick={() => act('remove')}>
                Remove
              </Button>
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
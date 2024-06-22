import { toFixed } from 'common/math';

import { useBackend } from '../backend';
import {
  Box,
  Button,
  LabeledList,
  NoticeBox,
  ProgressBar,
  Section,
} from '../components';
import { Window } from '../layouts';

interface Item {
  name: string;
  charge: number;
  ref: string;
}

interface FieldChargerData {
  items: Item[];
}

// UI for the field recharging station, which stores a list of items it charges
export const FieldCharger = (props) => {
  const { act, data } = useBackend<FieldChargerData>();

  return (
    <Window width={350} height={350}>
      <Window.Content scrollable>
        {/* Check if there are any items to display */}
        {data.items.length === 0 ? (
          // No items to display, so show big red banner saying so
          <NoticeBox color="red" textAlign="center">Insert a cell or device!</NoticeBox>
        ) : (
          // Render the items to display by iterating through the items list (items.map)
          <Section title="Items Stored">
            {data.items.map((item, index) => (
              <LabeledList key={index}>
                {/* Box serves as a wrapper so that there is some space between the items
                    The amount is smaller if the item is the last one to be displayed */}
                <Box mb={index === data.items.length - 1 ? 1 : 3}>
                  {/* Show the name of the item */}
                  <LabeledList.Item label="Name">
                    {item.name}
                  </LabeledList.Item>
                  {/* Show the charge of the cell in the form of a bar */}
                  <LabeledList.Item label="Charge">
                    <ProgressBar
                      value={item.charge / 100}
                      ranges={{
                      good: [0.75, Infinity],
                      average: [0.25, 0.75],
                      bad: [-Infinity, 0.25],
                      }}
                    >
                    {toFixed(item.charge) + '%'}
                    </ProgressBar>
                  </LabeledList.Item>
                  <LabeledList.Item>
                    <Button
                      content="Eject"
                      onClick={() => act('eject', { eject: item.ref })}
                    />
                  </LabeledList.Item>
                </Box>
              </LabeledList>
            ))}
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
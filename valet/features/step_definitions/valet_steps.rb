When(/^I park my car in the Valet Parking Lot for (.*)$/) do |duration|
  @page.text_field(:id, 'StartingDate').set '4/1/2014'
  @page.text_field(:id, 'LeavingDate').set '4/1/2014'
  @page.text_field(:id, 'LeavingTime').set '12:30'
end

Then(/^I will have to pay (.*)$/) do |price|
  @page.button(:value, 'Calculate').click
  actual_price = @page.table[3][1].text.split()[1].strip

  @price = price.split('$')[1].strip
  actual_price.should eq(@price),
    "Expected price of #{@price}, instead got price of #{actual_price}"
end

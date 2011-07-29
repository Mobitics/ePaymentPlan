Factory.define :payment_profile do |pp|
  pp.add_attribute :credit_card, {
    :number => 4007000000027,
    :month => 10,
    :year => 2011,
    :first_name => 'Bob',
    :last_name => 'Smith',
    :verification_value => '111',
    :type => 'visa'
  }
  pp.add_attribute :address, { 
    :name => 'Bob Smith', 
    :address1 => '123 Down the Road',
    :city => 'San Francisco', 
    :state => 'CA',
    :country => 'US',
    :zip => '23456',
    :phone => '(555)555-5555'
  }
end
require ('pry-byebug')
require_relative('./models/bounty')

bounty1 = Bounty.new({ 'name' => 'Marvin', 'danger_level' => 'low', 'bounty_value' => '12', 'fave_weapon' => 'toothpick'})

bounty2 = Bounty.new({ 'name' => 'Nicole', 'danger_level' => 'high', 'bounty_value' => '830', 'fave_weapon' => 'bazooka'})

Bounty.delete_all
bounty2.save
all_bounties = Bounty.all
p all_bounties

bounty2.name = 'Miles'
bounty2.update

 all_bounties = Bounty.all
 p all_bounties

# bounty2.delete

step "Are you talking about :name !!!!!" do |name|
  expect(name).to eq('Kuririn')
end

step "When you give up, that's when the game is over." do
  expect(true).to be true
end

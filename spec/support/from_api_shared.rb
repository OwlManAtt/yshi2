shared_examples_for "FromApi" do
  let(:importable) { described_class }

  it { should respond_to(:eve_id) }

  it "should find existing" do
    orig_thing = importable.make!
     
    new_thing = importable.find_or_create(:eve_id => orig_thing.eve_id, :name => 'test')
    new_thing.should eq orig_thing 
  end 

  it "should make new" do
    thing_for_id = importable.make!
    id = thing_for_id.id
    eve_id = thing_for_id.eve_id
    thing_for_id.delete

    now = Time.now

    thing = importable.find_or_create(:eve_id => eve_id, :name => 'test')
    thing.created_at.should_not eq id
  end
end

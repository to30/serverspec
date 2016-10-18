
require 'spec_helper'

 
describe port(30000) do
  it { should be_listening }
end

describe port(31000) do
  it { should be_listening }
end


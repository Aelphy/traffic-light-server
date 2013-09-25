#coding: utf-8
class TrafficLightBranch
  @@branch = 'sg-master'

  def self.get
    @@branch
  end

  def self.set(branch)
    @@branch = branch
  end
end

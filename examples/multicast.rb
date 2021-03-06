require 'rx'

subject = RX::Subject.new
source = RX::Observable.range(0, 3)
    .multicast(subject)

observer = RX::Observer.create(
    lambda {|x|
        puts 'Next: ' + x.to_s
    },
    lambda {|err|
        puts 'Error: ' + err.to_s
    },
    lambda {
        puts 'Completed'
    }
)

subscription = source.subscribe(observer)
subject.subscribe(observer)

connected = source.connect

subscription.dispose

# => Next: 0
# => Next: 0
# => Next: 1
# => Next: 1
# => Next: 2
# => Next: 2
# => Completed

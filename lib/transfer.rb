class Transfer
  # your code here

    attr_reader :status 
    attr_accessor :amount , :sender, :receiver 
    @@all = []

    def initialize(sender, receiver, amount)
      @sender = sender 
      @receiver = receiver
      @amount = amount 
      @@all << self 
      @status = "pending"
    end
  
    def self.all
      @@all
    end 

    def banks
      Bankaccount.all.select{|bank| bank.owner == self}
    end

    def valid?
      @sender.valid? && @receiver.valid?
    end
      

    def execute_transaction
      if sender.balance > @amount && valid? && @status == "pending"
        sender.balance -= amount
        receiver.balance += amount
        @status = "complete"
      else
        reject_transfer
      end
    end

    def reverse_transfer 
      if receiver.balance > @amount && valid? && @status == "complete"
        receiver.balance -= @amount 
        sender.balance += @amount
        @status = "reversed"
      else 
        reject_transfer
      end
    end



    def reject_transfer
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end

    
end

# Week 3 *(9/08/2025)*
### *General Meeting Notes*

### *Subteam Meeting Notes*


### *What I have done this week*
I am restructuring my RTL to fix the issue where the overwrite requests will be one clock cycle late. To do this I need to add a ROM section that contains the address values *0xC00 - 0xC1F*. These addresses are those of the lower 32 bits for each counter, the upper addresses will be checked by inverting the 7th bit (0 indexed) of the lower address, checking if it is equal to the address provided by the signal *priv.csr_addr*. The if statement will look like the following:
```sv
always_comb begin
    masked_address = {counter_address[i][11:8], ~counter_address[i][7], counter_address[i][6:0]};
// more code here ....
    if((counter_address[i] == priv.csr_addr) || (counter_address[i] == masked_address)  && priv.csr_active)
// more code here ...
end
```
For the counter selection section, I need to loop through the addresses in my ROM block, and make the above check. If there is a match, 

### *Questions I have*


### *Future plan*
***Before next meeting I need to:***
  - 

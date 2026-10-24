bill_denominations = {1, 5, 10, 20}

for index, denomination in ipairs(bill_denominations) do
    core.register_craftitem("vusd:bill_"..denomination, {
        description = "$"..denomination.." bill",
        inventory_image = denomination.."-vusd-bill.png"
    })
end

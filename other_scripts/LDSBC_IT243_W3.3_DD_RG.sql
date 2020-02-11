----ADDING CAPTION PROPERTY TO TABLE stg_p1

EXEC sp_addextendedproperty   
@name = N'Caption',   
@value = 'Postal code is a required column.',  
@level0type = N'Schema', @level0name = 'acct_id',  
@level1type = N'Table',  @level1name = 'stg_p1'


--Adding an input mask property to a column
  
  EXEC sp_addextendedproperty   
@name = N'Input Mask ', @value = '99999 or 99999-9999 or #### ###',  
@level0type = N'Schema', @level0name = 'acct_id',  
@level1type = N'Table', @level1name = 'stg_p2',   
@level2type = N'Column',@level2name = 'cust_id';  

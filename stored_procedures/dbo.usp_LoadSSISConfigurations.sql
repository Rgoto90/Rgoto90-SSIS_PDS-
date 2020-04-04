USE [SSIS_PDS]
GO

/****** Object:  StoredProcedure [dbo].[usp_LoadSSISConfigurations]    Script Date: 11/10/2019 12:27:40 AM ******/
DROP PROCEDURE [dbo].[usp_LoadSSISConfigurations]
GO

/****** Object:  StoredProcedure [dbo].[usp_LoadSSISConfigurations]    Script Date: 11/10/2019 12:27:40 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--


CREATE PROCEDURE [dbo].[usp_LoadSSISConfigurations]
AS
    BEGIN

/*****************************************************************************************************************
NAME:    dbo.usp_LoadSSISConfigurations
PURPOSE: Load the SSIS Configurations table

MODIFICATION LOG:
Ver      Date        Author           Description
-------  ----------  ---------------  ------------------------------------------------------------------------
1.0      04/01/2020  Rodrigo Goto 1. Created this process for LDS BC IT243
1.1      04/01/2020  Rodrigo Goto 1. Added conn_DFNB3 connection configuration
1.2      04/03/2020  Rodrigo Goto 1. Added LoadDFNB3_as Configuration
1.3      04/03/2020  Rodrigo Goto 1. Added LoadEXM_as Configuration



RUNTIME: 
approx 5 sec

NOTES:  
Load configured variable values for these levels...
1) System
2) Solution
3) Package


Loads configuration managers for common configuration managers used in template package

Connect strings are loaded with passwords to allow for automation of SSIS ETL based packages
         
******************************************************************************************************************/

    TRUNCATE TABLE dbo.[SSIS Configurations];


    -- 1) Common Configurations

    DELETE FROM dbo.[SSIS Configurations]
     WHERE ConfigurationFilter = 'CommonConfigurations';


    -- 1.1) conn_EXM

    INSERT INTO dbo.[SSIS Configurations](ConfigurationFilter
                                        , ConfiguredValue
                                        , PackagePath
                                        , ConfiguredValueType)
    VALUES
          (
           'CommonConfigurations'
         , 'Data Source=LAPTOP-6LBM68DT\MSSQLSERVER01;Initial Catalog=EXM;Provider=SQLNCLI11;Integrated Security=SSPI;'
         , '\Package.Variables[User::conn_EXM].Properties[Value]'
         , 'String'
          );


		   -- 1.2) conn_dfnb

    INSERT INTO dbo.[SSIS Configurations](ConfigurationFilter
                                        , ConfiguredValue
                                        , PackagePath
                                        , ConfiguredValueType)
    VALUES
          (
           'CommonConfigurations'
         , 'Data Source=LAPTOP-6LBM68DT\MSSQLSERVER01;Initial Catalog=DFNB3;Provider=SQLNCLI11;Integrated Security=SSPI;'
         , '\Package.Variables[User::conn_DFNB3].Properties[Value]'
         , 'String'
          );


		   -- 1.3) conn_ssis_pds

    INSERT INTO dbo.[SSIS Configurations](ConfigurationFilter
                                        , ConfiguredValue
                                        , PackagePath
                                        , ConfiguredValueType)
    VALUES
          (
           'CommonConfigurations'
         , 'Data Source=LAPTOP-6LBM68DT\MSSQLSERVER01;Initial Catalog=SSIS_PDS;Provider=SQLNCLI11;Integrated Security=SSPI;'
         , '\Package.Variables[User::conn_SSIS_PDS].Properties[Value]'
         , 'String'
          );



    -- 2) Solution Level Configurations


    -- 2.1) Rg
	
    DELETE FROM dbo.[SSIS Configurations]
     WHERE ConfigurationFilter = 'LDSBC_it243_rg';
	

	-- 2.1.1) v_data_share_root

    INSERT INTO dbo.[SSIS Configurations](ConfigurationFilter
                                        , ConfiguredValue
                                        , PackagePath
                                        , ConfiguredValueType)
    VALUES
          (
           'LDSBC_it243_rg'
		 , 'C:\repos\DFNB_src\txt_files\'
         , '\Package.Variables[User::v_data_share_root].Properties[Value]'
         , 'String'
          );





		  	

    -- 3) Package level configurations


    -- 3.1) SSIS_PDS_Template

    DELETE FROM dbo.[SSIS Configurations]
     WHERE ConfigurationFilter = 'SSIS_PDS_Template';
	

	-- 3.1.1) v_data_share_root

    INSERT INTO dbo.[SSIS Configurations](ConfigurationFilter
                                        , ConfiguredValue
                                        , PackagePath
                                        , ConfiguredValueType)
    VALUES
          (
           'SSIS_PDS_Template'
		 , 'C:\repos\DFNB_src\txt_files\'
         , '\Package.Variables[User::v_data_share_root].Properties[Value]'
         , 'String'
          );

		      -- 3.2) LoadDFNB3_as

    DELETE FROM dbo.[SSIS Configurations]
     WHERE ConfigurationFilter = 'LoadDFNB3_as';
	

	-- 3.2.1) v_data_share_root

    INSERT INTO dbo.[SSIS Configurations](ConfigurationFilter
                                        , ConfiguredValue
                                        , PackagePath
                                        , ConfiguredValueType)
    VALUES
          (
           'LoadDFNB3_as'
		 , 'C:\repos\DFNB_src\txt_files\'
         , '\Package.Variables[User::v_data_share_root].Properties[Value]'
         , 'String'
          );

		   -- 3.3) LoadEXM_as

    DELETE FROM dbo.[SSIS Configurations]
     WHERE ConfigurationFilter = 'LoadEXM_as';
	

	-- 3.3.1) v_data_share_root

    INSERT INTO dbo.[SSIS Configurations](ConfigurationFilter
                                        , ConfiguredValue
                                        , PackagePath
                                        , ConfiguredValueType)
    VALUES
          (
           'LoadEXM_as'
		 , 'C:\repos\EXM\txt_files\'
         , '\Package.Variables[User::v_data_share_root].Properties[Value]'
         , 'String'
          );
END;

GO



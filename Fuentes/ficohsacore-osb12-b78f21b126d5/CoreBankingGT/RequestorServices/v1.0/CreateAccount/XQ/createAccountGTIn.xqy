xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/accountsTypes";
(:: import schema at "../../../../../MWBanking/Accounts/RequestorServices/XSD/accountsTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/CreateAccountGT_BS";
(:: import schema at "../../../../ProviderServices/XSD/CreateAccount/CreateAccountGT_BS_sp.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $inputParameters as element() (:: schema-element(ns1:createAccountRequest) ::) external;

declare function xq:createAccountGTIn($inputParameters as element() (:: schema-element(ns1:createAccountRequest) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        {
            if ($inputParameters/ns1:CustomerCode)
            then <ns2:PN_CODIGO_CLIENTE>{fn:data($inputParameters/ns1:CustomerCode)}</ns2:PN_CODIGO_CLIENTE>
            else ()
        }
        {
            if ($inputParameters/ns1:InterfaceUser)
            then <ns2:PV_EJECUTIVO>{fn:data($inputParameters/ns1:InterfaceUser)}</ns2:PV_EJECUTIVO>
            else ()
        }
        {
            if ($inputParameters/ns1:GeneralInfo/com:BranchId)
            then <ns2:PN_CODIGO_AGENCIA>{fn:data($inputParameters/ns1:GeneralInfo/com:BranchId)}</ns2:PN_CODIGO_AGENCIA>
            else ()
        }
        {
            if ($inputParameters/ns1:AccountDetail/ns1:Category)
            then <ns2:PN_CODIGO_SUB_APLIC>{fn:data($inputParameters/ns1:AccountDetail/ns1:Category)}</ns2:PN_CODIGO_SUB_APLIC>
            else ()
        }
        {
            if ($inputParameters/ns1:GeneralInfo/com:ApplicationId)
            then <ns2:PV_CODIGO_APLICACION>{fn:data($inputParameters/ns1:GeneralInfo/com:ApplicationId)}</ns2:PV_CODIGO_APLICACION>
            else ()
        }
        {
            if ($inputParameters/ns1:AccountDetail/ns1:Currency)
            then <ns2:PV_MONEDA>{fn:data($inputParameters/ns1:AccountDetail/ns1:Currency)}</ns2:PV_MONEDA>
            else ()
        }
        {
            if ($inputParameters/ns1:AccountDetail/ns1:OperationType)
            then <ns2:PV_TIPO_OPERACION>{fn:data($inputParameters/ns1:AccountDetail/ns1:OperationType)}</ns2:PV_TIPO_OPERACION>
            else ()
        }
        {
            if ($inputParameters/ns1:AccountDetail/ns1:Passbook)
            then <ns2:PV_LIBRETA>{fn:data($inputParameters/ns1:AccountDetail/ns1:Passbook)}</ns2:PV_LIBRETA>
            else ()
        }
        {
            if ($inputParameters/ns1:AccountDetail/ns1:PassbookNumber)
            then <ns2:PN_NUM_LIBRETA>{fn:data($inputParameters/ns1:AccountDetail/ns1:PassbookNumber)}</ns2:PN_NUM_LIBRETA>
            else ()
        }
        {
            if ($inputParameters/ns1:AccountDetail/ns1:PayrollGroup)
            then <ns2:PV_CODIGO_G_PLANILLA>{fn:data($inputParameters/ns1:AccountDetail/ns1:PayrollGroup)}</ns2:PV_CODIGO_G_PLANILLA>
            else ()
        }
        {
            if ($inputParameters/ns1:AccountDetail/ns1:InitialDeposit)
            then <ns2:PN_DEP_INICIAL>{fn:data($inputParameters/ns1:AccountDetail/ns1:InitialDeposit)}</ns2:PN_DEP_INICIAL>
            else ()
        }
        {
            if ($inputParameters/ns1:AccountDetail/ns1:Purpose)
            then <ns2:PV_PROPOSITO_CTA>{fn:data($inputParameters/ns1:AccountDetail/ns1:Purpose)}</ns2:PV_PROPOSITO_CTA>
            else ()
        }
        {
            if ($inputParameters/ns1:AccountDetail/ns1:OrigenOfFunds)
            then <ns2:PV_ORIGEN_FONDOS>{fn:data($inputParameters/ns1:AccountDetail/ns1:OrigenOfFunds)}</ns2:PV_ORIGEN_FONDOS>
            else ()
        }
        {
            if ($inputParameters/ns1:AccountDetail/ns1:MonthlyTxnVolume)
            then <ns2:PV_VOL_TRX_MENSUAL>{fn:data($inputParameters/ns1:AccountDetail/ns1:MonthlyTxnVolume)}</ns2:PV_VOL_TRX_MENSUAL>
            else ()
        }
        {
            let $status := $inputParameters/ns1:AccountDetail/ns1:Inactive
            return (
              if ($status) then
                if(fn:string($status/text()) = "0")
                then (<ns2:PV_INACTIVA>ACTIVA</ns2:PV_INACTIVA>)
                else if (fn:string($status/text()) = "1")
                then (<ns2:PV_INACTIVA>INACTIVA</ns2:PV_INACTIVA>)
                else ()
              else ()
            )
        }
        {
            if ($inputParameters/ns1:BeneficiaryDetails)
            then <ns2:TR_BENEFICIARIOS>
                {
                    for $BeneficiaryDetail in $inputParameters/ns1:BeneficiaryDetails/ns1:BeneficiaryDetail
                    return 
                    <ns2:TR_BENEFICIARIOS_ITEM>
                        {
                            if ($BeneficiaryDetail/ns1:BeneficiaryName)
                            then <ns2:PV_NOMBRE_COMPLETO>{fn:data($BeneficiaryDetail/ns1:BeneficiaryName)}</ns2:PV_NOMBRE_COMPLETO>
                            else ()
                        }
                        {
                            if ($BeneficiaryDetail/ns1:DocumentType)
                            then <ns2:PV_TIPO_ID>{fn:data($BeneficiaryDetail/ns1:DocumentType)}</ns2:PV_TIPO_ID>
                            else ()
                        }
                        {
                            if ($BeneficiaryDetail/ns1:LegalId)
                            then <ns2:PV_IDENTIDAD>{fn:data($BeneficiaryDetail/ns1:LegalId)}</ns2:PV_IDENTIDAD>
                            else ()
                        }
                        {
                            if ($BeneficiaryDetail/ns1:Relation)
                            then <ns2:PV_PARENTESCO>{fn:data($BeneficiaryDetail/ns1:Relation)}</ns2:PV_PARENTESCO>
                            else ()
                        }
                        {
                            if ($BeneficiaryDetail/ns1:BeneficiaryPercentage)
                            then <ns2:PV_PORCENTAJE>{fn:data($BeneficiaryDetail/ns1:BeneficiaryPercentage)}</ns2:PV_PORCENTAJE>
                            else ()
                        }
                        {
                            if ($BeneficiaryDetail/ns1:Nationality)
                            then <ns2:PV_NACIONALIDAD>{fn:data($BeneficiaryDetail/ns1:Nationality)}</ns2:PV_NACIONALIDAD>
                            else ()
                        }
                        </ns2:TR_BENEFICIARIOS_ITEM>
                }</ns2:TR_BENEFICIARIOS>
            else ()
        }
        <ns2:TR_FIRMAS>
            {
                for $SignatoryDetails in $inputParameters/ns1:SignatoryDetails
                return 
                <ns2:TR_FIRMAS_ITEM>
                    {
                        if ($SignatoryDetails/ns1:RegisteredSignatory)
                        then <ns2:PN_CANT_FIRMANTES>{fn:data($SignatoryDetails/ns1:RegisteredSignatory)}</ns2:PN_CANT_FIRMANTES>
                        else ()
                    }
                    {
                        if ($SignatoryDetails/ns1:RequiredSignatory)
                        then <ns2:PN_CANT_FIRMAS_REQ>{fn:data($SignatoryDetails/ns1:RequiredSignatory)}</ns2:PN_CANT_FIRMAS_REQ>
                        else ()
                    }
                    <ns2:PN_CODIGO_CLIENTE></ns2:PN_CODIGO_CLIENTE>
                    {
                        if ($SignatoryDetails/ns1:DocumentType)
                        then <ns2:PN_TIPO_ID>{fn:data($SignatoryDetails/ns1:DocumentType)}</ns2:PN_TIPO_ID>
                        else ()
                    }
                    {
                        if ($SignatoryDetails/ns1:LegalId)
                        then <ns2:PV_IDENTIDAD>{fn:data($SignatoryDetails/ns1:LegalId)}</ns2:PV_IDENTIDAD>
                        else ()
                    }
                    {
                        if ($SignatoryDetails/ns1:SignatoryName)
                        then <ns2:PV_NOMBRE_COMPLETO>{fn:data($SignatoryDetails/ns1:SignatoryName)}</ns2:PV_NOMBRE_COMPLETO>
                        else ()
                    }
                    {
                        if ($SignatoryDetails/ns1:Relation)
                        then <ns2:PV_RELACION_TITULAR>{fn:data($SignatoryDetails/ns1:Relation)}</ns2:PV_RELACION_TITULAR>
                        else ()
                    }
                    {
                        if ($SignatoryDetails/ns1:CustomarClass)
                        then <ns2:PV_CLASE_CLIENTE>{fn:data($SignatoryDetails/ns1:CustomarClass)}</ns2:PV_CLASE_CLIENTE>
                        else ()
                    }
                    {
                        if ($SignatoryDetails/ns1:SignatureType)
                        then <ns2:PV_TIPO_FIRMA>{fn:data($SignatoryDetails/ns1:SignatureType)}</ns2:PV_TIPO_FIRMA>
                        else ()
                    }
                    {
                        if ($SignatoryDetails/ns1:Nationality)
                        then <ns2:PV_NACIONALIDAD>{fn:data($SignatoryDetails/ns1:Nationality)}</ns2:PV_NACIONALIDAD>
                        else ()
                    }
                    </ns2:TR_FIRMAS_ITEM>
            }</ns2:TR_FIRMAS>
    </ns2:InputParameters>
};

xq:createAccountGTIn($inputParameters)
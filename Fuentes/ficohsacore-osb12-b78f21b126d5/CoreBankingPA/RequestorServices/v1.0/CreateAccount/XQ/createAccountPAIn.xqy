xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/accountsTypes";
(:: import schema at "../../../../../MWBanking/Accounts/RequestorServices/XSD/accountsTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/CreateAccount_BS";
(:: import schema at "../../../../../CoreBankingGT/ProviderServices/XSD/CreateAccount/CreateAccount_BS_sp.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $createAccount as element() (:: schema-element(ns1:createAccountRequest) ::) external;


declare function xq:createAccountGTIn($createAccount as element() (:: schema-element(ns1:createAccountRequest) ::)) 
                                      as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        {
            if ($createAccount/ns1:CustomerCode)
            then <ns2:CODIGO_CLIENTE>{fn:data($createAccount/ns1:CustomerCode)}</ns2:CODIGO_CLIENTE>
            else ()
        }
        {
            if ($createAccount/ns1:AccountDetail/ns1:Category)
            then <ns2:CODIGO_SUB_APLICACION>{fn:data($createAccount/ns1:AccountDetail/ns1:Category)}</ns2:CODIGO_SUB_APLICACION>
            else ()
        }
        {
            if ($createAccount/ns1:AccountDetail/ns1:Currency)
            then <ns2:MONEDA>{fn:data($createAccount/ns1:AccountDetail/ns1:Currency)}</ns2:MONEDA>
            else ()
        }
        {
            if ($createAccount/ns1:AccountDetail/ns1:PayrollGroup)
            then <ns2:GRP_PLANILLA>{fn:data($createAccount/ns1:AccountDetail/ns1:PayrollGroup)}</ns2:GRP_PLANILLA>
            else ()
        }
        {
            if ($createAccount/ns1:AccountDetail/ns1:InitialDeposit)
            then <ns2:DEP_INICIAL>{fn:data($createAccount/ns1:AccountDetail/ns1:InitialDeposit)}</ns2:DEP_INICIAL>
            else ()
        }
        {
            if ($createAccount/ns1:AccountDetail/ns1:Purpose)
            then <ns2:PROPOSITO_CUENTA>{fn:data($createAccount/ns1:AccountDetail/ns1:Purpose)}</ns2:PROPOSITO_CUENTA>
            else ()
        }
        {
            if ($createAccount/ns1:AccountDetail/ns1:OrigenOfFunds)
            then <ns2:ORIGEN_FONDOS>{fn:data($createAccount/ns1:AccountDetail/ns1:OrigenOfFunds)}</ns2:ORIGEN_FONDOS>
            else ()
        }
        {
            if ($createAccount/ns1:AccountDetail/ns1:OperationType)
            then <ns2:CONDICION_CUENTA>{fn:data($createAccount/ns1:AccountDetail/ns1:OperationType)}</ns2:CONDICION_CUENTA>
            else ()
        }
        {
            if ($createAccount/ns1:GeneralInfo/com:ApplicationUser)
            then <ns2:CODIGO_USUARIO>{fn:data($createAccount/ns1:GeneralInfo/com:ApplicationUser)}</ns2:CODIGO_USUARIO>
            else ()
        }
        <ns2:CODIGO_EMPRESA>1</ns2:CODIGO_EMPRESA>
        {
            if ($createAccount/ns1:GeneralInfo/com:BranchId)
            then <ns2:CODIGO_AGENCIA>{fn:data($createAccount/ns1:GeneralInfo/com:BranchId)}</ns2:CODIGO_AGENCIA>
            else ()
        }
        <ns2:TR_BENEFICIARIOS>
            {
                for $BeneficiaryDetail in $createAccount/ns1:BeneficiaryDetails/ns1:BeneficiaryDetail
                return 
                <ns2:TR_BENEFICIARIOS_ITEM>
                    {
                        if ($BeneficiaryDetail/ns1:BeneficiaryName)
                        then <ns2:NOMBRE_BENEFICIARIO>{fn:data($BeneficiaryDetail/ns1:BeneficiaryName)}</ns2:NOMBRE_BENEFICIARIO>
                        else ()
                    }
                    {
                        if ($BeneficiaryDetail/ns1:Relation)
                        then <ns2:CODIGO_RELACION>{fn:data($BeneficiaryDetail/ns1:Relation)}</ns2:CODIGO_RELACION>
                        else ()
                    }
                    {
                        if ($BeneficiaryDetail/ns1:DocumentType)
                        then <ns2:TIPO_DOCUMENTO>{fn:data($BeneficiaryDetail/ns1:DocumentType)}</ns2:TIPO_DOCUMENTO>
                        else ()
                    }
                    {
                        if ($BeneficiaryDetail/ns1:LegalId)
                        then <ns2:IDENTIFICACION>{fn:data($BeneficiaryDetail/ns1:LegalId)}</ns2:IDENTIFICACION>
                        else ()
                    }
                    {
                        if ($BeneficiaryDetail/ns1:BeneficiaryPercentage)
                        then <ns2:PORCENTAJE>{fn:data($BeneficiaryDetail/ns1:BeneficiaryPercentage)}</ns2:PORCENTAJE>
                        else ()
                    }</ns2:TR_BENEFICIARIOS_ITEM>
            }
        </ns2:TR_BENEFICIARIOS>
        <ns2:TR_FIRMAS>
            {
                for $SignatoryDetails in $createAccount/ns1:SignatoryDetails
                return         
            <ns2:TR_FIRMAS_ITEM>
                {
                    if ($SignatoryDetails/ns1:RegisteredSignatory)
                    then <ns2:FIRMAS_REQUERIDAS>{fn:data($SignatoryDetails/ns1:RegisteredSignatory)}</ns2:FIRMAS_REQUERIDAS>
                    else ()
                }
                {
                    if ($SignatoryDetails/ns1:RequiredSignatory)
                    then <ns2:FIRMAS_REGISTRADAS>{fn:data($SignatoryDetails/ns1:RequiredSignatory)}</ns2:FIRMAS_REGISTRADAS>
                    else ()
                }
                {
                    if ($SignatoryDetails/ns1:SignatureType)
                    then <ns2:TIPO_FIRMA>{fn:data($SignatoryDetails/ns1:SignatureType)}</ns2:TIPO_FIRMA>
                    else ()
                }
                {
                    if ($SignatoryDetails/ns1:IdType)
                    then <ns2:TIPO_ID>{fn:data($SignatoryDetails/ns1:IdType)}</ns2:TIPO_ID>
                    else ()
                }
                {
                    if ($createAccount/ns1:SignatoryDetails/ns1:IdNumber)
                    then <ns2:NO_ID>{fn:data($createAccount/ns1:SignatoryDetails/ns1:IdNumber)}</ns2:NO_ID>
                    else ()
                }
                {
                    if ($SignatoryDetails/ns1:SignatoryDescription)
                    then <ns2:NOMBRE_FIRMANTE>{fn:data($SignatoryDetails/ns1:SignatoryDescription)}</ns2:NOMBRE_FIRMANTE>
                    else ()
                }
                {
                    if ($SignatoryDetails/ns1:IsMain)
                    then <ns2:OTRA_TITULAR>{fn:data($SignatoryDetails/ns1:IsMain)}</ns2:OTRA_TITULAR>
                    else ()
                }
            </ns2:TR_FIRMAS_ITEM>
            }
        </ns2:TR_FIRMAS>

    </ns2:InputParameters>
};

xq:createAccountGTIn($createAccount)

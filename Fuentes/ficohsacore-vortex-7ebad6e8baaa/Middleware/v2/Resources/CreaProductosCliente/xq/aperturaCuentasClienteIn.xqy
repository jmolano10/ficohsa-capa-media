xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$creaProductosCliente" element="ns1:creaProductosCliente" location="../xsd/creaProductosClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:AperturaCuentasCliente" location="../../../BusinessServices/T24/aperturaCuenta/xsd/XMLSchema_379817454.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/creaProductosClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaProductosCliente/xq/aperturaCuentasClienteIn/";

(: Función encargada de realizar el mapeo de usuario:)
declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };
 
declare function xf:aperturaCuentasClienteIn($requestHeader as element(ns2:RequestHeader),
    $creaProductosCliente as element(ns1:creaProductosCliente))
    as element(ns0:AperturaCuentasCliente) {
        <ns0:AperturaCuentasCliente>
             <WebRequestCommon>
				 <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                 <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
             <OfsFunction></OfsFunction>
            <FICOBULKAPPRCLNTINPUTPRODUCTWSType>
                <PROCESSTYPE>{ data($creaProductosCliente/PROCESS_TYPE) }</PROCESSTYPE>
                {
                    for $CATEGORY in $creaProductosCliente/ACCOUNT_DETAIL/CATEGORY
                    return
                        <CATEGORY>{ data($CATEGORY) }</CATEGORY>
                }
                {
                    for $CURRENCY in $creaProductosCliente/ACCOUNT_DETAIL/CURRENCY
                    return
                        <CURRENCY>{ data($CURRENCY) }</CURRENCY>
                }
                <CUSTOMER>{ data($creaProductosCliente/CUSTOMER_CODE) }</CUSTOMER>
                {
                    for $REFERRED_TYPE in $creaProductosCliente/ACCOUNT_DETAIL/REFERRED_TYPE
                    return
                        <REFEREDTYPE>{ data($REFERRED_TYPE) }</REFEREDTYPE>
                }
                {
                    for $PASSBOOK in $creaProductosCliente/ACCOUNT_DETAIL/PASSBOOK
                    return
                        <PASSBOOK>{ data($PASSBOOK) }</PASSBOOK>
                }
                {
                    for $PASSBOOK_NUMBER in $creaProductosCliente/ACCOUNT_DETAIL/PASSBOOK_NUMBER
                    return
                        <PASSBOOKNUMBER>{ data($PASSBOOK_NUMBER) }</PASSBOOKNUMBER>
                }
                {
                    for $PAYROLL_GROUP in $creaProductosCliente/ACCOUNT_DETAIL/PAYROLL_GROUP
                    return
                        <LRPAYROLLGRP>{ data($PAYROLL_GROUP) }</LRPAYROLLGRP>
                }
                {
                    for $INITIAL_DEPOSIT in $creaProductosCliente/ACCOUNT_DETAIL/INITIAL_DEPOSIT
                    return
                        <INITIALDEPOSIT>{ data($INITIAL_DEPOSIT) }</INITIALDEPOSIT>
                }
                {
                    for $PURPOSE in $creaProductosCliente/ACCOUNT_DETAIL/PURPOSE
                    return
                        <LRPURPOSE>{ data($PURPOSE) }</LRPURPOSE>
                }
                {
                    for $ORIGEN_OF_FUNDS in $creaProductosCliente/ACCOUNT_DETAIL/ORIGEN_OF_FUNDS
                    return
                        <LRORGOFFUNDS>{ data($ORIGEN_OF_FUNDS) }</LRORGOFFUNDS>
                }
                {
                    for $MONTHLY_TXN_VOLUME in $creaProductosCliente/ACCOUNT_DETAIL/MONTHLY_TXN_VOLUME
                    return
                        <LRMONTXVOL>{ data($MONTHLY_TXN_VOLUME) }</LRMONTXVOL>
                }
                {
                    for $ADDRESS_TYPE in $creaProductosCliente/ACCOUNT_DETAIL/ADDRESS_TYPE
                    return
                        <ADDRESSTYPE>{ data($ADDRESS_TYPE) }</ADDRESSTYPE>
                }
                {
                    for $REGISTERED_SIGNATORY in $creaProductosCliente/SIGNATORY_DETAILS/REGISTERED_SIGNATORY
                    return
                        <REGISTEREDSIGN>{ data($REGISTERED_SIGNATORY) }</REGISTEREDSIGN>
                }
                {
                    for $REQUIRED_SIGNATORY in $creaProductosCliente/SIGNATORY_DETAILS/REQUIRED_SIGNATORY
                    return
                        <REQUIREDSIGN>{ data($REQUIRED_SIGNATORY) }</REQUIREDSIGN>
                }
                {
                    for $SIGNATORY_DESCRIPTION in $creaProductosCliente/SIGNATORY_DETAILS/SIGNATORY_DESCRIPTION
                    return
                        <LRADDDESC>{ data($SIGNATORY_DESCRIPTION) }</LRADDDESC>
                }
                {
                    for $CARD_NUMBER in $creaProductosCliente/CARD_INFORMATION/CARD_NUMBER
                    return
                        <TDCODID>{ data($CARD_NUMBER) }</TDCODID>
                }
                {
                    for $PRIMARY_ACCOUNT in $creaProductosCliente/CARD_INFORMATION/PRIMARY_ACCOUNT
                    return
                        <PRIMARYACCT>{ data($PRIMARY_ACCOUNT) }</PRIMARYACCT>
                }
                {
                    for $DELIVERY_BRANCH in $creaProductosCliente/CARD_INFORMATION/DELIVERY_BRANCH
                    return
                        <TOAGENCY>{ data($DELIVERY_BRANCH) }</TOAGENCY>
                }
                {
                    for $EMISSION_PAY in $creaProductosCliente/CARD_INFORMATION/EMISSION_PAY
                    return
                        <LRREEMISIONTD>{ data($EMISSION_PAY) }</LRREEMISIONTD>
                }
                <gFIELDS81 g="1">
                    {
                        for $OPERATION_TYPE in $creaProductosCliente/ACCOUNT_DETAIL/OPERATION_TYPE
                        return
                            <LROPRTTYPE>{ data($OPERATION_TYPE) }</LROPRTTYPE>
                    }
                </gFIELDS81>
                {
                	let $BENEFICIARY_DETAIL := $creaProductosCliente/BENEFICIARY_DETAILS/BENEFICIARY_DETAIL
                	let $count := count($BENEFICIARY_DETAIL)
                	return(
                	
                	<gFIELDS86 g="{$count}">
                	{
                		for $NAMES in $BENEFICIARY_DETAIL
                		return
                        	<LRBENNAME>{ data($NAMES/BENEFICIARY_NAME) }</LRBENNAME>
                	}
                	</gFIELDS86>,
                	<gFIELDS87 g="{$count}">
                	{
                		for $RELATION in $BENEFICIARY_DETAIL
                		return
                     		<LRBENRELN>{ data($RELATION/RELATION) }</LRBENRELN>
                	}
                	</gFIELDS87>,
                	<gFIELDS88 g="{$count}">
                	{
                		for $RELATION in $BENEFICIARY_DETAIL
                		return
                     		<LRBENPRG>{ data($RELATION/BENEFICIARY_PERCENTAGE) }</LRBENPRG>
                	}
                	</gFIELDS88>,
                	 <gFIELDS89 g="{$count}">
                    {
                        for $DOCUMENT_TYPE in $BENEFICIARY_DETAIL
                        return
                            <LRTINACT>{ data($DOCUMENT_TYPE/DOCUMENT_TYPE) }</LRTINACT>
                    }
                	</gFIELDS89>,
                	<gFIELDS90>
                    {
                        for $PRIMARY_ACCOUNT in $BENEFICIARY_DETAIL
                    	return
                            <LRNUMACT>{ data($PRIMARY_ACCOUNT/LEGAL_ID) }</LRNUMACT>
                    }
                	</gFIELDS90>,
                	<gFIELDS91 g="{$count}">
                	{
                		for $DOCUMENT_TYPE in $BENEFICIARY_DETAIL
                		return
                    		<LRBENIDTYPE>{ data($DOCUMENT_TYPE/DOCUMENT_TYPE) }</LRBENIDTYPE>
                    }
                    </gFIELDS91>
                	)
                }
                <USERID>{ data($creaProductosCliente/INTERFACE_USER) }</USERID>
            </FICOBULKAPPRCLNTINPUTPRODUCTWSType>
        </ns0:AperturaCuentasCliente>
};

declare variable $requestHeader as element(ns2:RequestHeader) external;
declare variable $creaProductosCliente as element(ns1:creaProductosCliente) external;

xf:aperturaCuentasClienteIn($requestHeader,
    $creaProductosCliente)
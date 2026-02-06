xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$transferenciaCuentasRequest" element="ns1:transferenciaCuentasRequest" location="../xsd/transferenciaCuentasType.xsd" ::)
(:: pragma bea:global-element-return element="ns3:Desembolsoporcreditoacuenta" location="../../../BusinessServices/T24/DesembolsoPrestamoCreditoCuenta/xsd/svcDesembolsoPrestamoCredCtaTypes.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/kvpType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciasType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciaCuentas/xq/desembolsoPorCreditoACuentaIn/";
declare namespace ns3 = "T24WebServicesImpl";

declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare function xf:desembolsoPorCreditoACuentaIn($requestHeader as element(ns0:RequestHeader),
    $transferenciaCuentasRequest as element(ns1:transferenciaCuentasRequest))
    as element(ns3:Desembolsoporcreditoacuenta) {
        <ns3:Desembolsoporcreditoacuenta>
            <WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/UserName))
                    }
</userName>
                <password>
                    {
                        fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/Password))
                    }
</password>
            </WebRequestCommon>
            <OfsFunction>
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <FUNDSTRANSFERFICOHNDESEMBOLSOCTAHNL2Type>
                <DebitAmount>{ $transferenciaCuentasRequest/TRANSFER_AMOUNT/text() }</DebitAmount>
                <CreditAccount>{ $transferenciaCuentasRequest/CREDIT_ACCOUNT/text() }</CreditAccount>
                <gPAYMENTDETAILS>
                    <PaymentDetails>{ data($transferenciaCuentasRequest/DESCRIPTION) }</PaymentDetails>
                </gPAYMENTDETAILS>
                <LRLOANNO>{ data($transferenciaCuentasRequest/ADDITIONAL_INFO/KV_PAIR[KEY='LOAN_NUMBER']/VALUE) }</LRLOANNO>
            </FUNDSTRANSFERFICOHNDESEMBOLSOCTAHNL2Type>
        </ns3:Desembolsoporcreditoacuenta>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $transferenciaCuentasRequest as element(ns1:transferenciaCuentasRequest) external;

xf:desembolsoPorCreditoACuentaIn($requestHeader,
    $transferenciaCuentasRequest)
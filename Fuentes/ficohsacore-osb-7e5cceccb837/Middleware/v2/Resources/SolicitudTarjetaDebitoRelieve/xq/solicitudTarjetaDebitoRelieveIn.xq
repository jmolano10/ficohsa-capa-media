(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$solicitudTarjetaDebitoRelieve" element="ns2:solicitudTarjetaDebitoRelieve" location="../xsd/solicitudTarjetaDebitoRelieveTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:SolicituddeTDconRelieve" location="../../../../Business_Resources/tarjetasDebito/Resources/XMLSchema_-155258746.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/solicitudTarjetaDebitoRelieveTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SolicitudTarjetaDebitoRelieve/xq/solicitudTarjetaDebitoRelieve/";

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

declare function xf:solicitudTarjetaDebitoRelieve($requestHeader as element(ns0:RequestHeader),
    $solicitudTarjetaDebitoRelieve as element(ns2:solicitudTarjetaDebitoRelieve),
    $newSequency as xs:string)
    as element(ns1:SolicituddeTDconRelieve) {
        <ns1:SolicituddeTDconRelieve>
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
            <FICODEBITCARDISSUANCEFICOPRINCIPALWSType id = "{ concat(
                                                                     data($solicitudTarjetaDebitoRelieve/CUSTOMER_CODE/text()) , '.' , 
                                                                     data($solicitudTarjetaDebitoRelieve/CARD_TYPE/text()) , '.' , 
                                                                     $newSequency) }">
                <CustomerNo>{ data($solicitudTarjetaDebitoRelieve/CUSTOMER_CODE) }</CustomerNo>
                <gACCTCCY>
                    <mACCTCCY>
                        <AccountCurrency>{ data($solicitudTarjetaDebitoRelieve/CURRENCY_ACCOUNT) }</AccountCurrency>
                        <PrimaryAccount>{ data($solicitudTarjetaDebitoRelieve/PRIMARY_ACCOUNT) }</PrimaryAccount>
                    </mACCTCCY>
                </gACCTCCY>
                <NameOnPlastic>{ data($solicitudTarjetaDebitoRelieve/NAME_ON_PLASTIC) }</NameOnPlastic>
                <gDELIVERYADD>
                    <DeliveryAddress>{ data($solicitudTarjetaDebitoRelieve/DELIVERY_ADDRESS) }</DeliveryAddress>
                </gDELIVERYADD>
            </FICODEBITCARDISSUANCEFICOPRINCIPALWSType>
        </ns1:SolicituddeTDconRelieve>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $solicitudTarjetaDebitoRelieve as element(ns2:solicitudTarjetaDebitoRelieve) external;
declare variable $newSequency as xs:string external;

xf:solicitudTarjetaDebitoRelieve($requestHeader,
    $solicitudTarjetaDebitoRelieve,
    $newSequency)

xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:ReversarTransaccionesATMTengo" location="../../../BusinessServices/TENGO/svcReversarCuponCB/xsd/services_1.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversaCuponATM/xq/reversarTransaccionCuponT24In/";

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

declare function xf:reversarTransaccionCuponT24In($terminalref11 as xs:string,
    $referenciacb as xs:string,
    $terminalid41 as xs:string, 
    $fecha as xs:string,
    $usuario as xs:string)
    as element(ns0:ReversarTransaccionesATMTengo) {
    let $idtrx := fn:concat($terminalref11, "#", $referenciacb, "#", $terminalid41)
            return(
        <ns0:ReversarTransaccionesATMTengo>
           <WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( getUsername($usuario),'')
                    }
				</userName>
                <password>
                    {
                        fn-bea:fail-over( getPassword($usuario),'')
                    }
				</password>
            </WebRequestCommon>
        <OfsFunction>
          <noOfAuth>0</noOfAuth>
        </OfsFunction>
            <FICOHNATMVALCUPONCUPONType id = "{ $idtrx }">
                <FECHAREV>{ $fecha }</FECHAREV>
            </FICOHNATMVALCUPONCUPONType>
        </ns0:ReversarTransaccionesATMTengo>
        )
};

declare variable $terminalref11 as xs:string external;
declare variable $referenciacb as xs:string external;
declare variable $terminalid41 as xs:string external;
declare variable $fecha as xs:string external;
declare variable $usuario as xs:string external;

xf:reversarTransaccionCuponT24In($terminalref11,
    $referenciacb,
    $terminalid41,
    $fecha,
    $usuario)
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$actualizaDisponibleVentaMonedaExtranjera" element="ns1:actualizaDisponibleVentaMonedaExtranjera" location="../xsd/actualizaDisponibleVentaMonedaExtranjeraTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ActualizaDisponibleMonedaFCY" location="../../../BusinessServices/T24/MercadoLibre/xsd/XMLSchema_161558775.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/actualizaDisponibleVentaMonedaExtranjeraTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaDisponibleVentaMonedaExtranjera/xq/actualizaDisponibleVentaMonedaExtranjeraIn/";

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

(: Se encarga de convertir un date a string en formato "YYYYMMDD" :)
declare function date-to-string($fecha as xs:date) as xs:string
{
	concat(substring(xs:string($fecha), 1, 4), substring(xs:string($fecha), 6, 2), substring(xs:string($fecha), 9, 2))
};
declare function xf:actualizaDisponibleVentaMonedaExtranjeraIn($requestHeader as element(ns2:RequestHeader),
    $actualizaDisponibleVentaMonedaExtranjera as element(ns1:actualizaDisponibleVentaMonedaExtranjera))
    as element(ns0:ActualizaDisponibleMonedaFCY) {
        <ns0:ActualizaDisponibleMonedaFCY>
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
            	<gtsControl/>
				<messageId/>
				<noOfAuth/>
				<replace/>
            </OfsFunction>
            <FICOFXDEALSTXNINPUTType id = "{ data($actualizaDisponibleVentaMonedaExtranjera/DEAL) }">
                <Estado>{ data($actualizaDisponibleVentaMonedaExtranjera/STATUS) }</Estado>
                <Cliente>{ data($actualizaDisponibleVentaMonedaExtranjera/PROFILE) }</Cliente>
                <Moneda>{ data($actualizaDisponibleVentaMonedaExtranjera/CURRENCY) }</Moneda>
                <Monto>{ data($actualizaDisponibleVentaMonedaExtranjera/AMOUNT) }</Monto>
                <Fecha>{ date-to-string(current-date()) }</Fecha>
                <FechaVencimiento>{ data($actualizaDisponibleVentaMonedaExtranjera/END_DATE) }</FechaVencimiento>
                <TipodeOperacion>{ data($actualizaDisponibleVentaMonedaExtranjera/OPERATION_TYPE) }</TipodeOperacion>
                <TipodeAccion>{ data($actualizaDisponibleVentaMonedaExtranjera/ACTION_TYPE) }</TipodeAccion>
            </FICOFXDEALSTXNINPUTType>
        </ns0:ActualizaDisponibleMonedaFCY>
};

declare variable $requestHeader as element(ns2:RequestHeader) external;
declare variable $actualizaDisponibleVentaMonedaExtranjera as element(ns1:actualizaDisponibleVentaMonedaExtranjera) external;

xf:actualizaDisponibleVentaMonedaExtranjeraIn($requestHeader,
    $actualizaDisponibleVentaMonedaExtranjera)
xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$actualizaLlavesExpediente" element="ns1:actualizaLlavesExpediente" location="../../DigitalizacionExpediente/xsd/digitalizacionExpedienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:CambiarLlavesExpediente" location="../../../BusinessServices/TotalImage/totalImage/wsdl/TotalImageWS.wsdl" ::)

declare namespace ns0 = "http://interfase.bpm.sitecpro.com/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/digitalizacionExpedienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaLlavesExpediente/xq/cambiarLlavesExpedienteIn/";

declare function xf:cambiarLlavesExpedienteIn($actualizaLlavesExpediente as element(ns1:actualizaLlavesExpediente), $parameter as xs:string)
    as element(ns0:CambiarLlavesExpediente) {
        <ns0:CambiarLlavesExpediente>
            <ns0:Tpexp>{ data($actualizaLlavesExpediente/FILE_TYPE_NAME) }</ns0:Tpexp>
            <ns0:LlavesExpNomb>
            {
                   fn:string-join(for $llaveExpNom in $actualizaLlavesExpediente/CURRENT_KEY_INFO/ITEM/KEY
                   return $llaveExpNom, $parameter)
            }
            </ns0:LlavesExpNomb>
            <ns0:LlavesExpVal>
            {
                   fn:string-join(for $llaveExpVal in $actualizaLlavesExpediente/CURRENT_KEY_INFO/ITEM/VALUE
                   return $llaveExpVal, $parameter)
            }
            </ns0:LlavesExpVal>
            <ns0:LlavesExpNombNuevas>
            {
                   fn:string-join(for $llaveExpNomNuev in $actualizaLlavesExpediente/NEW_KEY_INFO/ITEM/KEY
                   return $llaveExpNomNuev, $parameter)
            }
            </ns0:LlavesExpNombNuevas>
            <ns0:LlavesExpValNuevas>
            {
                   fn:string-join(for $llaveExpValNuev in $actualizaLlavesExpediente/NEW_KEY_INFO/ITEM/VALUE
                   return $llaveExpValNuev, $parameter)
            }
            </ns0:LlavesExpValNuevas>
        </ns0:CambiarLlavesExpediente>
};

declare variable $actualizaLlavesExpediente as element(ns1:actualizaLlavesExpediente) external;
declare variable $parameter as xs:string external;

xf:cambiarLlavesExpedienteIn($actualizaLlavesExpediente,$parameter)
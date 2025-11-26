(:: pragma bea:global-element-parameter parameter="$creaExpediente1" element="ns1:creaExpediente" location="../../DigitalizacionExpediente/xsd/digitalizacionExpedienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:CrearExpediente" location="../../../BusinessServices/TotalImage/totalImage/wsdl/TotalImageWS.wsdl" ::)

declare namespace ns0 = "http://interfase.bpm.sitecpro.com/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/digitalizacionExpedienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaExpediente/xq/crearExpedienteIn/";

declare function xf:crearExpedienteIn($creaExpediente1 as element(ns1:creaExpediente), $parameter as xs:string)
    as element(ns0:CrearExpediente) {
        <ns0:CrearExpediente>
            <ns0:Tpexp>{ data($creaExpediente1/FILE_TYPE_NAME) }</ns0:Tpexp>
            <ns0:Codigo>{ data($creaExpediente1/ID) }</ns0:Codigo>
            <ns0:Agencia>{ data($creaExpediente1/AGENCY_NAME) }</ns0:Agencia>
            <ns0:Empresa>{ data($creaExpediente1/COMPANY_NAME) }</ns0:Empresa>
            <ns0:Archivador>{ data($creaExpediente1/STORAGE_NAME) }</ns0:Archivador>
            <ns0:Carpetas>{ data($creaExpediente1/DIRECTORIES) }</ns0:Carpetas>
            <ns0:LlavesExpNomb>
            {
                   fn:string-join(for $llaveExpNom in $creaExpediente1/KEY_INFO/ITEM/KEY
                   return $llaveExpNom, $parameter)
            }
            </ns0:LlavesExpNomb>
            <ns0:LlavesExpVal>
            {
                   fn:string-join(for $llaveExpVal in $creaExpediente1/KEY_INFO/ITEM/VALUE
                   return $llaveExpVal, $parameter)
            }
            </ns0:LlavesExpVal>
        </ns0:CrearExpediente>
};

declare variable $creaExpediente1 as element(ns1:creaExpediente) external;
declare variable $parameter as xs:string external;

xf:crearExpedienteIn($creaExpediente1,$parameter)

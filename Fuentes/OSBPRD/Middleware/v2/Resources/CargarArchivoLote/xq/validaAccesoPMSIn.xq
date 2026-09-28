(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$cargarArchivoLote1" element="ns1:cargarArchivoLote" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../BusinessServices/PMSV/validaAccesoPMS/xsd/validaAccesoPMS_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/validaAccesoPMS";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CargarArchivoLote/xq/validaAccesoPMSIn/";

declare function xf:validaAccesoPMSIn($requestHeader1 as element(ns0:RequestHeader),
    $cargarArchivoLote1 as element(ns1:cargarArchivoLote))
    as element(ns2:InputParameters) {
        <ns2:InputParameters>
            <ns2:CUSTOMER_ID>{ data($cargarArchivoLote1/CUSTOMER_ID) }</ns2:CUSTOMER_ID>
            <ns2:USER_NAME>{ data($requestHeader1/Authentication/UserName) }</ns2:USER_NAME>
        </ns2:InputParameters>
};

declare variable $requestHeader1 as element(ns0:RequestHeader) external;
declare variable $cargarArchivoLote1 as element(ns1:cargarArchivoLote) external;

xf:validaAccesoPMSIn($requestHeader1,
    $cargarArchivoLote1)
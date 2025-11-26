(:: pragma bea:global-element-parameter parameter="$actualizardatosdeclienteResponse1" element="ns1:ActualizardatosdeclienteResponse" location="../../../BusinessServices/actualizaDatosCliente/xsd/XMLSchema_1014999265.xsd" ::)
(:: pragma bea:global-element-return element="ns0:actualizaDatosClienteResponse" location="../xsd/actualizaDatosCliente.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/actualizaDatosClienteTypes/v2";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaDatosCliente/xq/ActualizaDatosClienteOut/";

declare function xf:ActualizaDatosClienteOut($actualizardatosdeclienteResponse1 as element(ns1:ActualizardatosdeclienteResponse))
    as element(ns0:actualizaDatosClienteResponse) {
        <ns0:actualizaDatosClienteResponse>
            <CUSTOMER_ID>{ data($actualizardatosdeclienteResponse1/CUSTOMERType/@id) }</CUSTOMER_ID>
            <CUSTOMER_NAME>{ data($actualizardatosdeclienteResponse1/CUSTOMERType/gSHORTNAME/SHORTNAME[1]) }</CUSTOMER_NAME>
        </ns0:actualizaDatosClienteResponse>
};

declare variable $actualizardatosdeclienteResponse1 as element(ns1:ActualizardatosdeclienteResponse) external;

xf:ActualizaDatosClienteOut($actualizardatosdeclienteResponse1)
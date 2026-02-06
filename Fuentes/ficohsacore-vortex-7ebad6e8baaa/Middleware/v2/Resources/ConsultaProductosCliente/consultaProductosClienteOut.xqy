xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$procesarResponse" element="ns1:procesarResponse" location="../../BusinessServices/enlace/xsd/Enlace.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaProductosClienteResponse" location="../OperacionesBilletera/xsd/operacionesBilleteraTypes.xsd" ::)

declare namespace ns1 = "http://main/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesBilleteraTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaProductosCliente/consultaProductosClienteOut/";

declare function xf:consultaProductosClienteOut($procesarResponse as element(ns1:procesarResponse))
    as element(ns0:consultaProductosClienteResponse) {
        <ns0:consultaProductosClienteResponse>
            {
                for $agentes in $procesarResponse/return/agentes
                return
                    <PRODUCT_DETAILS>
                        {
                            for $listClassAgente in $agentes/listClassAgente
                            return
                                <PRODUCT_DETAIL>
                                    <RTN>{ data($listClassAgente/RTNID) }</RTN>
                                    <TYPE_OF_PERSON>{ data($listClassAgente/tipoCliente) }</TYPE_OF_PERSON>
                                    <MERCHANT_TYPE>{ data($listClassAgente/tipoComercio) }</MERCHANT_TYPE>
                                    <PRODUCT_ID>{ data($listClassAgente/billetera) }</PRODUCT_ID>
                                    <STATUS>{ data($listClassAgente/estado) }</STATUS>
                                    <SEQUENCE>{ data($listClassAgente/secuencia) }</SEQUENCE>
                                    <DEPARTMENT_DESC>{ data($listClassAgente/departamento) }</DEPARTMENT_DESC>
                                    <MUNICIPALITY>{ data($listClassAgente/municipio) }</MUNICIPALITY>
                                    <ADDRESS>{ data($listClassAgente/direccion) }</ADDRESS>
                                    <POINT_OF_SALE_NAME>{ data($listClassAgente/nombreAgente) }</POINT_OF_SALE_NAME>
                                    <CUSTOMER_SINCE>{ data($listClassAgente/fechaInsert) }</CUSTOMER_SINCE>
                                    <LAST_MODIFIED_DATE>{ data($listClassAgente/fechaHModifico) }</LAST_MODIFIED_DATE>
                                    <CREATED_BY>{ data($listClassAgente/usuarioInsert) }</CREATED_BY>
                                    <MODIFIED_BY>{ data($listClassAgente/usuarioModifico) }</MODIFIED_BY>
                                </PRODUCT_DETAIL>
                        }
                    </PRODUCT_DETAILS>
            }
        </ns0:consultaProductosClienteResponse>
};

declare variable $procesarResponse as element(ns1:procesarResponse) external;

xf:consultaProductosClienteOut($procesarResponse)
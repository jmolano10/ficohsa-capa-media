(:: pragma bea:global-element-parameter parameter="$actualizaEstadoReprocesoACH" element="ns0:actualizaEstadoReprocesoACH" location="../xsd/actualizaEstadoReprocesoACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ActualizaEstadoReprocesoACH/xsd/ActualizaEstadoReprocesoACH_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/actualizaEstadoReprocesoACHTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ActualizaEstadoReprocesoACH";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaEstadoReprocesoACH/xq/ActualizaEstadoReprocesoACHIn/";

declare function xf:ActualizaEstadoReprocesoACHIn($actualizaEstadoReprocesoACH as element(ns0:actualizaEstadoReprocesoACH))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_PXPIDREF>{ data($actualizaEstadoReprocesoACH/LEGEND_BANK_ISSUER[1]) }</ns1:PV_PXPIDREF>
            <ns1:PV_REF_CONTROL_T24>{ data($actualizaEstadoReprocesoACH/REF_CONTROL_T24[1]) }</ns1:PV_REF_CONTROL_T24>
            <ns1:PV_CUSTOMER_ID>{ data($actualizaEstadoReprocesoACH/CUSTOMER_ID[1]) }</ns1:PV_CUSTOMER_ID>
            <ns1:PV_IS_LBTR>{ data($actualizaEstadoReprocesoACH/IS_LBTR[1]) }</ns1:PV_IS_LBTR>
            <ns1:PV_FT_TRANSACCIONT24>{ data($actualizaEstadoReprocesoACH/FT_TRANSACTION[1]) }</ns1:PV_FT_TRANSACCIONT24>
            <ns1:PV_ESTADOPROCESO>{ data($actualizaEstadoReprocesoACH/STATUS[1]) }</ns1:PV_ESTADOPROCESO>
            <ns1:PV_TIPOTRANSACCION>{ data($actualizaEstadoReprocesoACH/TRANSACTION_TYPE[1]) }</ns1:PV_TIPOTRANSACCION>
            <ns1:PV_CODIGOERRORPROCESO>{ data($actualizaEstadoReprocesoACH/REJECTION_CODE[1]) }</ns1:PV_CODIGOERRORPROCESO>
            <ns1:PV_MENSAJEERRORPROCESO>{ data($actualizaEstadoReprocesoACH/REJECTION_MESSAGE[1]) }</ns1:PV_MENSAJEERRORPROCESO>
        </ns1:InputParameters>
};

declare variable $actualizaEstadoReprocesoACH as element(ns0:actualizaEstadoReprocesoACH) external;

xf:ActualizaEstadoReprocesoACHIn($actualizaEstadoReprocesoACH)

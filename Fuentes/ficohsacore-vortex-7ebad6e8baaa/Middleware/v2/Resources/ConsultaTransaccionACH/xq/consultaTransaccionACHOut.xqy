xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/ACH/Recibido/ConsultaEstadoTransaccionACH/xsd/consultaEstadoTransaccionACH_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaTransaccionACHResponse" location="../xsd/consultaTransaccionACHTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaEstadoTransaccionACH";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaTransaccionACHTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTransaccionACH/xq/consultaTransaccionACHOut/";

declare function xf:consultaTransaccionACHOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:consultaTransaccionACHResponse) {
        <ns1:consultaTransaccionACHResponse>
            <TRANSACTIONS>
                <TRANSACTION_RECORD>
                    {
                        for $PV_PXPIDREF in $outputParameters/ns0:PV_PXPIDREF
                        return
                            <DETAIL_ID>{ data($PV_PXPIDREF) }</DETAIL_ID>
                    }
                    {
                        for $PV_PXPLOTEREF in $outputParameters/ns0:PV_PXPLOTEREF
                        return
                            <TRANSACTION_ID>{ data($PV_PXPLOTEREF) }</TRANSACTION_ID>
                    }
                    {
                        for $PV_CUENTABENEFICIARIA in $outputParameters/ns0:PV_CUENTABENEFICIARIA
                        return
                            <RECEIVING_ACCOUNT>{ data($PV_CUENTABENEFICIARIA) }</RECEIVING_ACCOUNT>
                    }
                    {
                        for $PV_ESTADO in $outputParameters/ns0:PV_ESTADO
                        return
                            <STATUS>{ data($PV_ESTADO) }</STATUS>
                    }
                    <AMOUNT>{ data($outputParameters/ns0:PN_MONTO) }</AMOUNT>
                </TRANSACTION_RECORD>
            </TRANSACTIONS>
        </ns1:consultaTransaccionACHResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultaTransaccionACHOut($outputParameters)
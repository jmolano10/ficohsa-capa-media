(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns2:OutputParameters" location="../../../BusinessServices/ABK/consultarDeudoresClienteDepRef/xsd/consultarDeudoresClienteDepRef_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaDeudoresResponse" location="../../DepositosReferenciados/xsd/depositosReferenciadosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/depositosReferenciadosTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarDeudoresClienteDepRef";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/PagingTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDeudoresDepRef/xq/consultarDeudoresClienteDepRefOut/";

declare function xf:consultarDeudoresClienteDepRefOut($outputParameters1 as element(ns2:OutputParameters))
    as element(ns0:consultaDeudoresResponse) {
        <ns0:consultaDeudoresResponse>
            {
                for $PV_CODIGOCLIENTE in $outputParameters1/ns2:PV_CODIGOCLIENTE
                return
                    <CUSTOMER_ID>{ data($PV_CODIGOCLIENTE) }</CUSTOMER_ID>
            }
            {
                for $PV_NROCUENTA in $outputParameters1/ns2:PV_NROCUENTA
                return
                    <ACCOUNT_NUMBER>{ data($PV_NROCUENTA) }</ACCOUNT_NUMBER>
            }
            <RECORDS_INFO>
                <INITIAL_RECORD>{ data($outputParameters1/ns2:PN_REGINICIAL) }</INITIAL_RECORD>
                <RECORDS_RETURNED>{ data($outputParameters1/ns2:PN_CANTREGISTROS) }</RECORDS_RETURNED>
                <RECORD_TOTAL>{ data($outputParameters1/ns2:PN_TOTREGISTROS) }</RECORD_TOTAL>
            </RECORDS_INFO>
            <DEBTORS>            
                {
                    let $pn_cantidad := $outputParameters1/ns2:PN_CANTREGISTROS
                    let $pt_codigos := $outputParameters1/ns2:PT_CODIGOS/ns2:ITEM
                    let $pt_nombres := $outputParameters1/ns2:PT_NOMBRES/ns2:ITEM
                    let $pt_iddocumentos := $outputParameters1/ns2:PT_IDDOCUMENTOS/ns2:ITEM
                    let $pt_estados := $outputParameters1/ns2:PT_ESTADOS/ns2:ITEM
                    let $pt_estadosdesc := $outputParameters1/ns2:PT_ESTADOSDESC/ns2:ITEM
                    for $idx in 1 to $pn_cantidad
                    return
                        <DEBTOR>
                            <DEBTOR_CODE>{ data($pt_codigos[$idx]) }</DEBTOR_CODE>
                            <DEBTOR_NAME>{ data($pt_nombres[$idx]) }</DEBTOR_NAME>
                            <DOCUMENT_ID>{ data($pt_iddocumentos[$idx]) }</DOCUMENT_ID>
                            <STATUS>{ data($pt_estados[$idx]) }</STATUS>
                            <DESCRIPTION>{ data($pt_estadosdesc[$idx]) }</DESCRIPTION>
                        </DEBTOR>
                }
            </DEBTORS>
            
        </ns0:consultaDeudoresResponse>
};

declare variable $outputParameters1 as element(ns2:OutputParameters) external;

xf:consultarDeudoresClienteDepRefOut($outputParameters1)
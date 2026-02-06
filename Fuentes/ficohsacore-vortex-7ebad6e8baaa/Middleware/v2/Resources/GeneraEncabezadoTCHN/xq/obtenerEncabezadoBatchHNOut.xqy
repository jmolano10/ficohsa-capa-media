xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$conInfoHistoricaTCResponse" element="ns0:OutputParameters" location="../../../BusinessServices/ProcesosHN/conInfoHistoricaTC/xsd/conInfoHistoricaTC_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$generaEncabezadoTCResponse" element="ns1:generaEncabezadoTCResponse" location="../../GeneraEstadoCuenta/xsd/generaEstadoCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:generaEncabezadoTCResponse" location="../../GeneraEstadoCuenta/xsd/generaEstadoCuentaTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conInfoHistoricaTC";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/generaEstadoCuentaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GeneraEncabezadoTCHN/xq/obtenerEncabezadoBatchHNOut/";

declare function xf:obtenerEncabezadoBatchHNOut($conInfoHistoricaTCResponse as element(ns0:OutputParameters),
    $generaEncabezadoTCResponse as element(ns1:generaEncabezadoTCResponse))
    as element(ns1:generaEncabezadoTCResponse) {
        <ns1:generaEncabezadoTCResponse>
            {
                for $DatoObtenerEncabezadosV2RecordType in $generaEncabezadoTCResponse/DatoObtenerEncabezadosV2RecordType
                return
                    <DatoObtenerEncabezadosV2RecordType>
                        {
                            for $BALANCE in $DatoObtenerEncabezadosV2RecordType/BALANCE
                            return
                                <BALANCE>{ data($BALANCE) }</BALANCE>
                        }
                        {
                            for $CYCLE in $DatoObtenerEncabezadosV2RecordType/CYCLE
                            return
                                <CYCLE>{ data($CYCLE) }</CYCLE>
                        }
                        {
                            for $CURRENCY in $DatoObtenerEncabezadosV2RecordType/CURRENCY
                            return
                                <CURRENCY>{ data($CURRENCY) }</CURRENCY>
                        }
                        {
                            for $CYCLE_DUE in $DatoObtenerEncabezadosV2RecordType/CYCLE_DUE
                            return
                                <CYCLE_DUE>{ data($CYCLE_DUE) }</CYCLE_DUE>
                        }
                        {
                            for $CUTOFF_DATE in $DatoObtenerEncabezadosV2RecordType/CUTOFF_DATE
                            return
                                <CUTOFF_DATE>{ data($CUTOFF_DATE) }</CUTOFF_DATE>
                        }
                        {
                            for $FILE_LINK in $DatoObtenerEncabezadosV2RecordType/FILE_LINK
                            return
                                <FILE_LINK>{ data($FILE_LINK) }</FILE_LINK>
                        }
                        {
                            for $MILES_EARNED in $DatoObtenerEncabezadosV2RecordType/MILES_EARNED
                            return
                                <MILES_EARNED>{ data($MILES_EARNED) }</MILES_EARNED>
                        }
                        {
                            for $ACCOUNT_NUMBER in $DatoObtenerEncabezadosV2RecordType/ACCOUNT_NUMBER
                            return
                                <ACCOUNT_NUMBER>{ data($ACCOUNT_NUMBER) }</ACCOUNT_NUMBER>
                        }
                        {
                            for $ORG in $DatoObtenerEncabezadosV2RecordType/ORG
                            return
                                <ORG>{ data($ORG) }</ORG>
                        }
                        {
                            for $MIN_PAYMENT in $DatoObtenerEncabezadosV2RecordType/MIN_PAYMENT
                            return
                                <MIN_PAYMENT>{ data($MIN_PAYMENT) }</MIN_PAYMENT>
                        }
                        {
                            for $TOTAL_PAYMENT in $DatoObtenerEncabezadosV2RecordType/TOTAL_PAYMENT
                            return
                                <TOTAL_PAYMENT>{ data($TOTAL_PAYMENT) }</TOTAL_PAYMENT>
                        }
                        {
                            for $PERIOD in $DatoObtenerEncabezadosV2RecordType/PERIOD
                            return
                                <PERIOD>{ data($PERIOD) }</PERIOD>
                        }
                        {
                            for $POINT_EARNED in $DatoObtenerEncabezadosV2RecordType/POINT_EARNED
                            return
                                <POINT_EARNED>{ data($POINT_EARNED) }</POINT_EARNED>
                        }
                        {
                            for $OVERDUE_AMOUNT in $DatoObtenerEncabezadosV2RecordType/OVERDUE_AMOUNT
                            return
                                <OVERDUE_AMOUNT>{ data($OVERDUE_AMOUNT) }</OVERDUE_AMOUNT>
                        }
                        {
                            for $TYPE_ORG in $DatoObtenerEncabezadosV2RecordType/TYPE_ORG
                            return
                                <TYPE_ORG>{ data($TYPE_ORG) }</TYPE_ORG>
                        }
                        {
                            for $LOGO in $DatoObtenerEncabezadosV2RecordType/LOGO
                            return
                                <LOGO>{ data($LOGO) }</LOGO>
                        }
                        {
                            for $LOGO_NAME in $DatoObtenerEncabezadosV2RecordType/LOGO_NAME
                            return
                                <LOGO_NAME>{ data($LOGO_NAME) }</LOGO_NAME>
                        }
                        {
                            for $SHIPPING_TYPE in $DatoObtenerEncabezadosV2RecordType/SHIPPING_TYPE
                            return
                                <SHIPPING_TYPE>{ data($SHIPPING_TYPE) }</SHIPPING_TYPE>
                        }
                        {
                            for $conInfoHistoricaTC in $conInfoHistoricaTCResponse/ns0:RowSet/ns0:Row[ns0:Column[@name = 'CodMoneda']/text() = data($DatoObtenerEncabezadosV2RecordType/CURRENCY)][1]
            				return
								<LAST_CUTOFF_TOTAL_PAYMENT>
								{
									let $TotalPayment := data($conInfoHistoricaTC/ns0:Column[@name = 'actualdue'])
                    				return
                    				$TotalPayment
                    			}
   								</LAST_CUTOFF_TOTAL_PAYMENT> 
                        }
                    </DatoObtenerEncabezadosV2RecordType>
            }
        </ns1:generaEncabezadoTCResponse>
};

declare variable $conInfoHistoricaTCResponse as element(ns0:OutputParameters) external;
declare variable $generaEncabezadoTCResponse as element(ns1:generaEncabezadoTCResponse) external;

xf:obtenerEncabezadoBatchHNOut($conInfoHistoricaTCResponse,
    $generaEncabezadoTCResponse)
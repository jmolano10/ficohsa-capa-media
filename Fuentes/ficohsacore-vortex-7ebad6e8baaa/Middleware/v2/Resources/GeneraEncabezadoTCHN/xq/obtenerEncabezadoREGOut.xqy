xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$obtenerEncabezadosV2Response" element="ns0:ObtenerEncabezadosV2Response" location="../../../BusinessServices/VisionPlusREG/obtenerSerializado/xsd/bfemEECCHistorico.xsd" ::)
(:: pragma bea:global-element-return element="ns1:generaEncabezadoTCResponse" location="../../GeneraEstadoCuenta/xsd/generaEstadoCuentaTypes.xsd" ::)

declare namespace ns2 = "http://schemas.datacontract.org/2004/07/BF.Tarjetas.bfemEstadosCuentas.DataContracts";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/generaEstadoCuentaTypes";
declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GeneraEncabezadoTCHN/xq/obtenerEncabezadoREGOut/";

declare function xf:obtenerEncabezadoHNOut($obtenerEncabezadosV2Response as element(ns0:ObtenerEncabezadosV2Response))
    as element(ns1:generaEncabezadoTCResponse) {
        <ns1:generaEncabezadoTCResponse>
            {
                for $DatoObtenerEncabezadosV2 in $obtenerEncabezadosV2Response/ns0:ObtenerEncabezadosV2Result/ns2:Encabezados/ns2:DatoObtenerEncabezadosV2
                return
                    <DatoObtenerEncabezadosV2RecordType>
                        {
                            for $Balance in $DatoObtenerEncabezadosV2/ns2:Balance
                            return
                                <BALANCE>{ data($Balance) }</BALANCE>
                        }
                        {
                            for $Ciclo in $DatoObtenerEncabezadosV2/ns2:Ciclo
                            return
                                <CYCLE>{ data($Ciclo) }</CYCLE>
                        }
                        {
                            for $CodMoneda in $DatoObtenerEncabezadosV2/ns2:CodMoneda
                            return
                                <CURRENCY>{ data($CodMoneda) }</CURRENCY>
                        }
                        {
                            for $CycleDue in $DatoObtenerEncabezadosV2/ns2:CycleDue
                            return
                                <CYCLE_DUE>{ data($CycleDue) }</CYCLE_DUE>
                        }
                        {
                            for $FechaCorte in $DatoObtenerEncabezadosV2/ns2:FechaCorte
                            return
                                <CUTOFF_DATE>{ data($FechaCorte) }</CUTOFF_DATE>
                        }
                        {
                            for $FileLink in $DatoObtenerEncabezadosV2/ns2:FileLink
                            return
                                <FILE_LINK>{ data($FileLink) }</FILE_LINK>
                        }
                        {
                            for $MilesEarned in $DatoObtenerEncabezadosV2/ns2:MilesEarned
                            return
                                <MILES_EARNED>{ data($MilesEarned) }</MILES_EARNED>
                        }
                        {
                            for $NumCuenta in $DatoObtenerEncabezadosV2/ns2:NumCuenta
                            return
                                <ACCOUNT_NUMBER>{ data($NumCuenta) }</ACCOUNT_NUMBER>
                        }
                        {
                            for $Org in $DatoObtenerEncabezadosV2/ns2:Org
                            return
                                <ORG>{ data($Org) }</ORG>
                        }
                        {
                            for $PagoMinimo in $DatoObtenerEncabezadosV2/ns2:PagoMinimo
                            return
                                <MIN_PAYMENT>{ data($PagoMinimo) }</MIN_PAYMENT>
                        }
                        {
                            for $PagoTotal in $DatoObtenerEncabezadosV2/ns2:PagoTotal
                            return
                                <TOTAL_PAYMENT>{ data($PagoTotal) }</TOTAL_PAYMENT>
                        }
                        {
                            for $Periodo in $DatoObtenerEncabezadosV2/ns2:Periodo
                            return
                                <PERIOD>{ data($Periodo) }</PERIOD>
                        }
                        {
                            for $PointEarned in $DatoObtenerEncabezadosV2/ns2:PointEarned
                            return
                                <POINT_EARNED>{ data($PointEarned) }</POINT_EARNED>
                        }
                        {
                            for $SaldoMora in $DatoObtenerEncabezadosV2/ns2:SaldoMora
                            return
                                <OVERDUE_AMOUNT>{ data($SaldoMora) }</OVERDUE_AMOUNT>
                        }
                        {
                            for $TipoOrg in $DatoObtenerEncabezadosV2/ns2:TipoOrg
                            return
                                <TYPE_ORG>{ data($TipoOrg) }</TYPE_ORG>
                        }
                    </DatoObtenerEncabezadosV2RecordType>
            }
        </ns1:generaEncabezadoTCResponse>
};

declare variable $obtenerEncabezadosV2Response as element(ns0:ObtenerEncabezadosV2Response) external;

xf:obtenerEncabezadoHNOut($obtenerEncabezadosV2Response)
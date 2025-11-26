xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns3:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudoMultiple" element="ns1:pagoRecaudoMultiple" location="../../xsds/PagoRecaudoMultiple/PagoRecaudoMultiple.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns2:OutputParameters" location="../../xsds/Recaudos/ConsultarRelacionOperacionRecaudoMultiple/FLINK_OSB_CON_OPER_RECAUDO_MULTIPLE.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Pagoderecaudolocalylineachqin" location="../../xsds/PagoRecaudos/XMLSchema_-258408779.xsd" ::)

declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudoMultiple/PagoRecaudoMultipleEnLineaChequeInternacionalUSIn/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoMultipleTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_CON_OPER_RECAUDO_MULTIPLE/";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";

declare function xf:PagoRecaudoMultipleEnLineaChequeInternacionalUSIn($autenticacionRequestHeader as element(ns3:AutenticacionRequestHeader),
    $pagoRecaudoMultiple as element(ns1:pagoRecaudoMultiple),
    $outputParameters as element(ns2:OutputParameters),
    $uuid as xs:string)
    as element(ns0:Pagoderecaudolocalylineachqin) {
        <ns0:Pagoderecaudolocalylineachqin>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <gtsControl/>
                <messageId>{ $uuid }</messageId>
                <noOfAuth/>
                <replace/>
            </OfsFunction>
            <TELLERLATAMDIRCHQINTLWSType>
                <PAYEECCY>{ data($pagoRecaudoMultiple/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</PAYEECCY>
                <gCHEQUENUMBER>
                    <mCHEQUENUMBER>
                        {
                            for $CHEQUE_NUMBER in $pagoRecaudoMultiple/PAYMENT_INFORMATION/CHEQUE_NUMBER
                            return
                                <CHEQUENUMBER>{ data($CHEQUE_NUMBER) }</CHEQUENUMBER>
                        }
                        {
                            for $BANK_CODE in $pagoRecaudoMultiple/PAYMENT_INFORMATION/BANK_CODE
                            return
                                <BANKSORTCODE>{ data($BANK_CODE) }</BANKSORTCODE>
                        }
                        {
                            for $DEBIT_ACCOUNT in $pagoRecaudoMultiple/PAYMENT_INFORMATION/DEBIT_ACCOUNT
                            return
                                <CHEQUEACCOUNTNUMBER>{ data($DEBIT_ACCOUNT) }</CHEQUEACCOUNTNUMBER>
                        }
                    </mCHEQUENUMBER>
                </gCHEQUENUMBER>
                <LRPAYCODE>{ data($pagoRecaudoMultiple/DEBTOR_CODE) }</LRPAYCODE>
                <gLRINVOICENO>
                    {
                    	let $CODIGO_FACTURA := $outputParameters/ns2:CODIGO_FACTURA/ns2:ITEM
                    	let $FECHA_FACTURA := $outputParameters/ns2:FECHA_FACTURA/ns2:ITEM
                    	let $FECHA_VENCIMIENTO := $outputParameters/ns2:FECHA_VENCIMIENTO/ns2:ITEM
                    	let $MONEDA_FACTURA := $outputParameters/ns2:MONEDA_FACTURA/ns2:ITEM
                    	let $MONTO_FACTURA := $outputParameters/ns2:MONTO_FACTURA/ns2:ITEM
                    	let $MONEDAS_SOLICITUD := $outputParameters/ns2:MONEDAS_SOLICITUD/ns2:ITEM
                    	let $MORA := $outputParameters/ns2:MORA/ns2:ITEM
                    	let $MONTO_TOTAL := $outputParameters/ns2:MONTO_TOTAL/ns2:ITEM
                    	let $montoPago := $pagoRecaudoMultiple/PAYMENT_INFORMATION/PAYMENT_AMOUNT
                    	let $monedaPago := $pagoRecaudoMultiple/PAYMENT_INFORMATION/PAYMENT_CURRENCY
                    	let $totalFacturas := $outputParameters/ns2:TOTAL_FACTURAS
                        for $i in 1 to count($CODIGO_FACTURA)
                        return
                            <mLRINVOICENO>
                                <LRINVOICENO>{ data($CODIGO_FACTURA[$i]) }</LRINVOICENO>
                                <LRINVOICEDT>{ data($FECHA_FACTURA[$i]) }</LRINVOICEDT>
                                <LRDUEDATE>{ data($FECHA_VENCIMIENTO[$i]) }</LRDUEDATE>
                                <LRAMT>{ concat($MONEDA_FACTURA[$i] , fn-bea:fail-over(fn-bea:format-number(round-half-to-even($MONTO_FACTURA[$i],2),"######0.00"),'0.00')) }</LRAMT>
                                {
                                	if( number($MORA[$i]) != 0 and string(number($MORA[$i])) != 'NaN') then (
                                		<LRPENALITYAMT>{ concat($MONEDA_FACTURA[$i] , $MORA[$i]) }</LRPENALITYAMT>
                                	) else ()
                                }
                                <LRTOTALAMT>{ concat($MONEDAS_SOLICITUD[$i] , fn-bea:fail-over(fn-bea:format-number(round-half-to-even($MONTO_TOTAL[$i],2),"######0.00"),'0.00')) }</LRTOTALAMT>
                                {
                                	if( number($montoPago) != number($totalFacturas) ) then (
										<LRPARTIALAMT>{ fn-bea:fail-over(fn-bea:format-number(round-half-to-even($montoPago,2),"######0.00"),'0.00') }</LRPARTIALAMT>
                                						
                                	) else ()
                                }
                                <LRPAYYN>Y</LRPAYYN>
                            </mLRINVOICENO>
                    }
                </gLRINVOICENO>       
                <LRAGCLIENTID>{ data($pagoRecaudoMultiple/CONTRACT_ID) }</LRAGCLIENTID>
            </TELLERLATAMDIRCHQINTLWSType>
        </ns0:Pagoderecaudolocalylineachqin>
};

declare variable $autenticacionRequestHeader as element(ns3:AutenticacionRequestHeader) external;
declare variable $pagoRecaudoMultiple as element(ns1:pagoRecaudoMultiple) external;
declare variable $outputParameters as element(ns2:OutputParameters) external;
declare variable $uuid as xs:string external;

xf:PagoRecaudoMultipleEnLineaChequeInternacionalUSIn($autenticacionRequestHeader,
    $pagoRecaudoMultiple,
    $outputParameters,
    $uuid)
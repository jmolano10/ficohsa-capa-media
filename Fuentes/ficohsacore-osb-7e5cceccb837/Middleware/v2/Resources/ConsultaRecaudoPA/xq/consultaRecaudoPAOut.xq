(:: pragma bea:global-element-parameter parameter="$registrarConsultaRecaudo" element="ns0:OutputParameters" location="../../../BusinessServices/TercerosPA/registrarConsultaRecaudo/xsd/registrarConsultaRecaudo_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns2:consultaRecaudoResponse" location="../../ConsultaRecaudo/xsd/consultaRecaudoTypes.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarConsultaRecaudo";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRecaudoPA/xq/consultaRecaudoPAOut/";

declare function xf:consultaRecaudoPAOut(
    $registrarConsultaRecaudo as element(ns0:OutputParameters))
    as element(ns2:consultaRecaudoResponse) {
        <ns2:consultaRecaudoResponse>
            {
                for $PV_IDCONVENIO in $registrarConsultaRecaudo/ns0:PV_IDCONVENIO
                return
                    <CONTRACT_ID>{ data($PV_IDCONVENIO) }</CONTRACT_ID>
            }
            {
                for $PV_NOMBRECONVENIO in $registrarConsultaRecaudo/ns0:PV_NOMBRECONVENIO
                return
                    <CONTRACT_NAME>{ data($PV_NOMBRECONVENIO) }</CONTRACT_NAME>
            }
            {
                for $PV_CODIGODEUDOR in $registrarConsultaRecaudo/ns0:PV_CODIGODEUDOR
                return
                    <DEBTOR_CODE>{ data($PV_CODIGODEUDOR) }</DEBTOR_CODE>
            }
            {
                for $PV_NOMBREDEUDOR in $registrarConsultaRecaudo/ns0:PV_NOMBREDEUDOR
                return
                    <DEBTOR_NAME>{ data($PV_NOMBREDEUDOR) }</DEBTOR_NAME>
            }
            {
                for $PC_RECIBOHTML in $registrarConsultaRecaudo/ns0:PC_RECIBOHTML
                return
                    <BILL_DETAIL>{ data($PC_RECIBOHTML) }</BILL_DETAIL>
            }
            {
                for $PT_REGISTRO in $registrarConsultaRecaudo/ns0:PT_REGISTRO
                return
                    <BILLS>
                        <BILL_RECORD>
                        {
                                let $PT_REGISTRO_ITEM := $PT_REGISTRO/ns0:PT_REGISTRO_ITEM
                            	return
                            	(                      
                                        let $numFactura := $PT_REGISTRO_ITEM[ns0:NAME ='NumFactura']/ns0:VALUE/text()
                                        return
                                            <BILL_NUMBER>{ data($numFactura) }</BILL_NUMBER>,


                                        let $currency := $PT_REGISTRO_ITEM[ns0:NAME ='Moneda']/ns0:VALUE/text()
                                        return
                                            <BILL_CURRENCY>{ data($currency) }</BILL_CURRENCY>,

 
                                        let $fechaFactura := $PT_REGISTRO_ITEM[ns0:NAME ='FechaFactura']/ns0:VALUE/text()
                                        return
                                        	if($fechaFactura != "")then
                                        	(
                                        		 <BILL_DATE>{ fn-bea:date-to-string-with-format("yyyyMMdd",fn-bea:date-from-string-with-format("dd-MMM-yy",$fechaFactura)) }</BILL_DATE>
                                        		 
                                        	)else(),
                                        	
                                        	
                                        let $fechaVencimiento := $PT_REGISTRO_ITEM[ns0:NAME ='FechaVencimiento']/ns0:VALUE/text()
                                        return
                                        	if($fechaVencimiento != "")then
                                        	(
                                        		 <DUE_DATE>{ fn-bea:date-to-string-with-format("yyyyMMdd",fn-bea:date-from-string-with-format("dd-MMM-yy",$fechaVencimiento)) }</DUE_DATE>
                                        		 
                                        	)else(),
                                        	                                         

                                        let $monto := $PT_REGISTRO_ITEM[ns0:NAME ='Monto']/ns0:VALUE/text()
                                        return
                                        	<BILL_AMOUNT>{ data($monto) }</BILL_AMOUNT>,
										<LATE_FEE></LATE_FEE>,
                                        let $montoLoc := $PT_REGISTRO_ITEM[ns0:NAME ='Monto']/ns0:VALUE/text()
                                        return
                                            <TOTAL_AMOUNT_LOC>{ data($montoLoc) }</TOTAL_AMOUNT_LOC>,
                                       <TOTAL_AMOUNT_USD></TOTAL_AMOUNT_USD>,
                                       <BILL_DESCRIPTION></BILL_DESCRIPTION>

                               )
                            }
                            </BILL_RECORD>
                    </BILLS>
            }
        </ns2:consultaRecaudoResponse>
};

declare variable $registrarConsultaRecaudo as element(ns0:OutputParameters) external;

xf:consultaRecaudoPAOut($registrarConsultaRecaudo)
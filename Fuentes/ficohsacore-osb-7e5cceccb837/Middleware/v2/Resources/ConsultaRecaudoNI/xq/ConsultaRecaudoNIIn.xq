(:: pragma bea:global-element-parameter parameter="$consultaRecaudo1" element="ns3:consultaRecaudo" location="../../ConsultaRecaudo/xsd/consultaRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/TercerosNI/consultaConvenio/xsd/ConsultaConvenio_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaRecaudoSolicitud" location="../../../BusinessServices/CTS/convenio/xsd/services.xsd" ::)

declare namespace ns0 = "http://service.srvaplcobisrecaudo.ecobis.cobiscorp";
declare namespace ns2 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaRecaudoNI";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRecaudoNI/xq/consultaRecaudoNIIn/";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";

declare function xf:consultaRecaudoNIIn($consultaRecaudo1 as element(ns3:consultaRecaudo),
    $outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaRecaudoSolicitud) {
        <ns0:consultaRecaudoSolicitud>
            {
                for $PV_COBRANZA in $outputParameters/ns1:PV_COBRANZA
                return
                    <ns2:cobranza>{ data($PV_COBRANZA) }</ns2:cobranza>
            }
            {
                for $PV_IDCONVENIONI in $outputParameters/ns1:PV_IDCONVENIONI
                return
                    <ns2:contractId>{ data($PV_IDCONVENIONI) }</ns2:contractId>
            }
            <ns2:debtorCode>{ data($consultaRecaudo1/DEBTOR_CODE) }</ns2:debtorCode>
            <ns2:currency>{ data($consultaRecaudo1/CURRENCY) }</ns2:currency>
            <ns2:billAmount> 
            {
            	let $data := data($consultaRecaudo1/BILL_AMOUNT)
            	return
            	if ( $data = '') then (
			  		"0"
				)else (
					$data
				)
			} 
            </ns2:billAmount>
            <ns2:billDate>{ data($consultaRecaudo1/BILL_DATE)}</ns2:billDate>
            {
                for $BILL_RETURN_TYPE in $consultaRecaudo1/BILL_RETURN_TYPE
                return
                    <ns2:billReturnType>{ data($BILL_RETURN_TYPE) }</ns2:billReturnType>
            }
            {
                for $EXTENDED_COLLECTION_YES_NO in $consultaRecaudo1/EXTENDED_COLLECTION_YES_NO
                return
                    <ns2:extendedCollection>{ data($EXTENDED_COLLECTION_YES_NO) }</ns2:extendedCollection>
            }
            {
                for $ADDITIONAL_INFO in $consultaRecaudo1/ADDITIONAL_INFO
                return
                    <ns2:additionalInfo>
                        {
                        let $data := data($consultaRecaudo1/EXTENDED_COLLECTION_YES_NO)
            			return
            				if ( $data = 'YES') then (
			  					 for $DATA in $ADDITIONAL_INFO/DATA
                            	return
                                	<ns2:data>{ data($DATA) }</ns2:data>
							)else (
								<ns2:data/>
							)
                           
                        }
                    </ns2:additionalInfo>
            }
        </ns0:consultaRecaudoSolicitud>
};

declare variable $consultaRecaudo1 as element(ns3:consultaRecaudo) external;
declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaRecaudoNIIn($consultaRecaudo1,
    $outputParameters)
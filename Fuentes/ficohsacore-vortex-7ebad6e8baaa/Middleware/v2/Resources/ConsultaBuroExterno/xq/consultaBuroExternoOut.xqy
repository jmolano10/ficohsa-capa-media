xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaReferenciasResponse1" element="ns0:ConsultaReferenciasResponse" location="../../../BusinessServices/APC/wsdl/APC.asmx.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:consultaBuroExternoResponse" location="../xsd/consultaBuroExternoTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaBuroExterno/xq/consultaBuroExternoOut/";
declare namespace ns0 = "http://tempuri.org/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaBuroExternoTypes";

declare function xf:consultaBuroExternoOut($consultaReferenciasResponse1 as element(ns0:ConsultaReferenciasResponse))
    as element(ns1:consultaBuroExternoResponse) {
        <ns1:consultaBuroExternoResponse>
        {
        	if(count($consultaReferenciasResponse1/ns0:ConsultaReferenciasResult/ns0:ListaReferencias/ns0:ReferenciasDTO) > 0)then(
        		<RESULTS>
        			{
        				for $reference in $consultaReferenciasResponse1/ns0:ConsultaReferenciasResult/ns0:ListaReferencias/ns0:ReferenciasDTO
        				return(
        					<RESULT>
        						<TYPE_REFERENCE>{ data($reference/ns0:TipoReferencia) }</TYPE_REFERENCE>
        						<NUMBER_ASOC>{ data($reference/ns0:NombreAsociacion) }</NUMBER_ASOC>
        						<NUM_REFER>{ substring(data($reference/ns0:NumeroReferencia),7,4) }</NUM_REFER>
        						<SHORT_DESCRIPTION_RELATION>{ data($reference/ns0:DescripcionCortaRelacion) }</SHORT_DESCRIPTION_RELATION>
        						<DATE_RELATION> { fn-bea:dateTime-to-string-with-format("yyyyMMdd", data($reference/ns0:FechaInicioRelacion)) }</DATE_RELATION>
        						{
        							if(string($reference/ns0:FechaFinRelacion/text())!='')then( 
            							<END_DATE_RELATION>{ fn-bea:dateTime-to-string-with-format("yyyyMMdd", data($reference/ns0:FechaFinRelacion)) }</END_DATE_RELATION>
                    				)else()
								}
								<LIMIT_AMOUNT> {xs:decimal(data(string($reference/ns0:LimiteMonto/text())))} </LIMIT_AMOUNT>
								<PAYMENT_NUMBER> {xs:short(data(string($reference/ns0:NumeroPagos/text())))} </PAYMENT_NUMBER>
								<DESCRIPTION_PAY_METHOD>{ data($reference/ns0:DescripcionFormaPago) }</DESCRIPTION_PAY_METHOD>
								<PAYMENT_AMOUNT> {xs:decimal(data(string($reference/ns0:ImportePago/text())))} </PAYMENT_AMOUNT>
								{
                					if(string($reference/ns0:FechaUltimoPago/text())!='')then( 
            							<LAST_DATE_PAYMENT>{ fn-bea:dateTime-to-string-with-format("yyyyMMdd", data($reference/ns0:FechaUltimoPago)) }</LAST_DATE_PAYMENT>
            						)else()
            					}
            					{
                					if(string($reference/ns0:MontoUltimoPago/text())!='')then( 
            							<LAST_PAY_AMOUNT> {xs:decimal(data(string($reference/ns0:MontoUltimoPago/text())))} </LAST_PAY_AMOUNT>
            						)else()
            					}   
            					<SHORT_DESCRIPTION>{ data($reference/ns0:DescripcionObservacionCorta) }</SHORT_DESCRIPTION>
            					<CURRENT_BALANCE> {xs:decimal(data(string($reference/ns0:SaldoActual/text())))} </CURRENT_BALANCE>
            					<NUMBER_DAYS_DELAYED>{ data($reference/ns0:NumeroDiasAtraso) }</NUMBER_DAYS_DELAYED>
            					{
                					if(string($reference/ns0:Historia/text())!='')then( 
                    					<HISTORICAL>{ data($reference/ns0:Historia) }</HISTORICAL>
                    				)else()
            					}
            					<UPDATE>{ fn-bea:dateTime-to-string-with-format("yyyyMMdd", data($reference/ns0:FechaActualizacion)) }</UPDATE>
            					<ECONOMIC_GROUP_CODE>{ data($reference/ns0:CodigoGrupoECON) }</ECONOMIC_GROUP_CODE>
            					<TYPE_ASSOCIATION>{ data($reference/ns0:TipoAsociacion) }</TYPE_ASSOCIATION>
        					</RESULT>
        				)
        			}
        		</RESULTS>
        	)else()
        }
        </ns1:consultaBuroExternoResponse>
};

declare variable $consultaReferenciasResponse1 as element(ns0:ConsultaReferenciasResponse) external;

xf:consultaBuroExternoOut($consultaReferenciasResponse1)
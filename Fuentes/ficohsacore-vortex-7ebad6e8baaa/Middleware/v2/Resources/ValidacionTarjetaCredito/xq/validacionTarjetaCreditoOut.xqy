(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/ValidacionTarjetaCredito/xsd/ConsultaDatosTarjetaCredito_sp.xsd" ::)
(:: pragma bea:global-element-return element="val:validacionTarjetaCreditoResponse" location="../xsd/validacionTarjetaCreditoType.xsd" ::)

declare namespace val = "http://www.ficohsa.com.hn/middleware.services/validacionTarjetaCreditoType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaDatosTarjetaCredito";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidacionTarjetaCredito/xq/validacionTarjetaCreditoOut/";
declare namespace con = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaDatosTarjetaCredito";

declare function xf:validacionTarjetaCreditoOut($outputParameters1 as element(ns0:OutputParameters))
    as element(val:validacionTarjetaCreditoResponse) {
        <val:validacionTarjetaCreditoResponse>            
            {
            	<ACCOUNT_NUMBER>{ fn:string($outputParameters1/con:RowSet[1]/con:Row[1]/con:Column[@name='cuenta']/text()) }</ACCOUNT_NUMBER>,
            	<CREDIT_CARD_NAME>{ fn:string($outputParameters1/con:RowSet[1]/con:Row[1]/con:Column[@name='nombre']/text()) }</CREDIT_CARD_NAME>,
                <CUSTOMER_NUMBER>{ fn:string($outputParameters1/con:RowSet[1]/con:Row[1]/con:Column[@name='numcliente']/text()) }</CUSTOMER_NUMBER>,
            	<CREDIT_CARD_NUMBER>{ fn:string($outputParameters1/con:RowSet[1]/con:Row[1]/con:Column[@name='numtarjeta']/text()) }</CREDIT_CARD_NUMBER>,
                  for $RowSet in $outputParameters1/ns0:RowSet/ns0:Row
                    return(
                    <CREDIT_CARD_INFORMATION>              
                      <CURRENCY>{ data($RowSet/con:Column[@name = 'moneda']/text()) }</CURRENCY>
                      <COD_BLOCK>{ data($RowSet/con:Column[@name = 'codbloque']/text()) }</COD_BLOCK>  
                      <ORG>{ data($RowSet/con:Column[@name = 'org']/text()) }</ORG>   	                             
                      <ORG_TYPE>{ data($RowSet/con:Column[@name = 'TipoOrg']/text()) }</ORG_TYPE>                                                                                                          
                    </CREDIT_CARD_INFORMATION>     
                )
            }
        </val:validacionTarjetaCreditoResponse>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:validacionTarjetaCreditoOut($outputParameters1)
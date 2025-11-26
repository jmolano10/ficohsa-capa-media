(:: pragma bea:global-element-parameter parameter="$consultaEstadoCuentaTCHistorico" element="ns0:consultaEstadoCuentaTCHistorico" location="../../../../Business_Resources/tarjetaCredito/ConsultaEstadoCuentaTCHistorico/consultaEstadoCuentaTCHistoricoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaECHistResponse" element="ns1:ConsultaECHistResponse" location="../../../../Business_Resources/tarjetaCredito/Resources/TarjetaDeCredito.wsdl" ::)
(:: pragma bea:global-element-return element="ns2:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://tempuri.org/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaEstadoCuentaTCHistoricoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoCuentaTCHistorico/xq/consultaEstadoCuentaTCHistHeaderOut/";

declare function xf:consultaEstadoCuentaTCHistHeaderOut($consultaEstadoCuentaTCHistorico as element(ns0:consultaEstadoCuentaTCHistorico),
    $consultaECHistResponse as element(ns1:ConsultaECHistResponse))
    as element(ns2:ResponseHeader) {
        <ns2:ResponseHeader>
	        {
	        	let $CARD_NUMBER := data($consultaEstadoCuentaTCHistorico/CARD_NUMBER)
	        	let $YEAR :=data($consultaEstadoCuentaTCHistorico/YEAR)
                let $MONTH :=data($consultaEstadoCuentaTCHistorico/MONTH) 
                return
                if(string($CARD_NUMBER) = "" or string($MONTH ) = ""  or string($YEAR) = "")then(
	        		 <successIndicator>ERROR</successIndicator>,
	 				 <messages>REQUIRED FIELDS NOT SUPPLIED</messages>
	        	)else if(empty($consultaECHistResponse/ns1:ConsultaECHistResult/ns1:saldos/ns1:ArrayOfStrucSaldosEstado))then(
	        		<successIndicator>NO RECORDS</successIndicator>,
	  				 <messages>0 records returned</messages>
	        	)else(
	        		<successIndicator>SUCCESS</successIndicator>
	        	)
	        }           
        </ns2:ResponseHeader>
};

declare variable $consultaEstadoCuentaTCHistorico as element(ns0:consultaEstadoCuentaTCHistorico) external;
declare variable $consultaECHistResponse as element(ns1:ConsultaECHistResponse) external;

xf:consultaEstadoCuentaTCHistHeaderOut($consultaEstadoCuentaTCHistorico,
    $consultaECHistResponse)

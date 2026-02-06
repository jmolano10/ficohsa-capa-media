xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../../../v3/BusinessServices/MasterData/conConsultaDatosTCRG/xsd/conConsultaDatosTarjetaCredito_v3_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:OutputParameters" location="../../../../../v3/BusinessServices/MasterData/conConsultaDatosTCRG/xsd/conConsultaDatosTarjetaCredito_v3_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conConsultaDatosTarjetaCredito_v3";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldosTarjetaCredito/xq/cache/conDatosCompletoOut/";

declare function xf:conDatosCompletoOut($outputParameters1 as element(ns0:OutputParameters))
    as element(ns0:OutputParameters) {
        <ns0:OutputParameters>
            <ns0:RowSet>
            	{
            		if(count($outputParameters1/ns0:RowSet[1]/ns0:Row) eq 2)then(
            			for $columna in $outputParameters1/ns0:RowSet[1]/ns0:Row
	                 	return $columna
            		)else(
	                 	for $columna in $outputParameters1/ns0:RowSet[1]/ns0:Row[1]
                 		return $columna,
	                 		(<ns0:Row>
								<ns0:Column name="TipoOrg" sqltype="varchar">
                                    {
                                        if($outputParameters1/ns0:RowSet[1]/ns0:Row[1]/ns0:Column[@name='TipoOrg']/text() = 'ALT')then(
                                            'BASE'
                                        )else('ALT')
                                    }
                                </ns0:Column>
								<ns0:Column name="org" sqltype="numeric">0</ns0:Column>
								<ns0:Column name="CodMoneda" sqltype="varchar">GTQ</ns0:Column>
								<ns0:Column name="numtarjeta" sqltype="varchar"></ns0:Column>
								<ns0:Column name="card_holder_id" sqltype="varchar"> </ns0:Column>
								<ns0:Column name="account_holder_legal_id" sqltype="varchar"> </ns0:Column>
								<ns0:Column name="customer_id" sqltype="varchar"></ns0:Column>
								<ns0:Column name="account_name" sqltype="varchar"></ns0:Column>
								<ns0:Column name="cardholder_name" sqltype="varchar"></ns0:Column>
								<ns0:Column name="shortname" sqltype="varchar"></ns0:Column>
								<ns0:Column name="logo" sqltype="numeric"></ns0:Column>
								<ns0:Column name="estatus" sqltype="varchar"></ns0:Column>
								<ns0:Column name="numcuenta" sqltype="varchar"></ns0:Column>
								<ns0:Column name="fecultemision" sqltype="datetime" xsi:nil="true"/>
								<ns0:Column name="fecexpira" sqltype="datetime">2026-06-30T00:00:00.000-06:00</ns0:Column>
								<ns0:Column name="billed_bal" sqltype="numeric">0.00</ns0:Column>
								<ns0:Column name="intra_end_bal" sqltype="numeric">0.00</ns0:Column>
								<ns0:Column name="amt_access_chks_1" sqltype="numeric">0.00</ns0:Column>
								<ns0:Column name="FechaUltPago" sqltype="numeric">0.00</ns0:Column>
							</ns0:Row>)
						)
                 }
            </ns0:RowSet>
        </ns0:OutputParameters>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:conDatosCompletoOut($outputParameters1)
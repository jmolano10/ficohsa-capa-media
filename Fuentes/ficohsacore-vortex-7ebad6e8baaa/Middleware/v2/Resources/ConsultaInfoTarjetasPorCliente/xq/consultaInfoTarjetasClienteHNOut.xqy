xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/MasterDataHN/consultaInfoTarjetasPorCliente/xsd/consultaInfoTarjetasPorCliente_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaInfoTarjetasPorClienteResponse" location="../xsd/consultaInfoTarjetasPorClienteTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaInfoTarjetasPorClienteTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaInfoTarjetasPorCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaInfoTarjetasPorCliente/xq/consultaInfoTarjetasClienteHNOut/";

declare function xf:consultaInfoTarjetasClienteHNOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaInfoTarjetasPorClienteResponse) {
        <ns0:consultaInfoTarjetasPorClienteResponse>
  		{
  			for $CUSTOMER_ID in $outputParameters/ns1:RowSet/ns1:Row[1]/ns1:Column[upper-case(@name) = "NUMCLIENTE"]
  			return
  			<CUSTOMER_ID>{ data($CUSTOMER_ID) }</CUSTOMER_ID>
  		}
  		{
  			for $ACCOUNT_NUMBER in distinct-values($outputParameters/ns1:RowSet/ns1:Row/ns1:Column[upper-case(@name) = "NUMCUENTA"])
  			return(
  				<ns0:ACCOUNT_INFO>
  					<ACCOUNT_NUMBER>{ $ACCOUNT_NUMBER }</ACCOUNT_NUMBER>
  					{
  						for $CARD_NUMBER in distinct-values($outputParameters/ns1:RowSet/ns1:Row/ns1:Column[upper-case(@name) = "NUMTARJETA"])
  						return(
  							for $ORG_BASE in $outputParameters/ns1:RowSet/ns1:Row where $ORG_BASE/ns1:Column[upper-case(@name) = "NUMTARJETA"] = $CARD_NUMBER and $ORG_BASE/ns1:Column[upper-case(@name) = "NUMCUENTA"] = $ACCOUNT_NUMBER and $ORG_BASE/ns1:Column[upper-case(@name) = "TIPOORG"] = "BASE"
  							for $CARD_ROW in $outputParameters/ns1:RowSet/ns1:Row where $CARD_ROW/ns1:Column[upper-case(@name) = "NUMTARJETA"] = $CARD_NUMBER and $CARD_ROW/ns1:Column[upper-case(@name) = "NUMCUENTA"] = $ACCOUNT_NUMBER and $CARD_ROW/ns1:Column[upper-case(@name) = "ORG"] = $ORG_BASE/ns1:Column[upper-case(@name) = "ORG"] 
  							return(
  								<ns0:CARD_INFO>
  									<CARD_NUMBER>{ $CARD_NUMBER }</CARD_NUMBER>
  									{
  										for $CARD_HOLDER_NAME in $CARD_ROW/ns1:Column[upper-case(@name) = "NOMBTARJETA1"]
  										return
  										<CARD_HOLDER_NAME> { data($CARD_HOLDER_NAME) } </CARD_HOLDER_NAME>
  									}
  									{
  										for $CARD_TYPE_CODE in $CARD_ROW/ns1:Column[upper-case(@name) = "CARDHOLDER_TYPE"]
  										return
  										<CARD_TYPE_CODE> { data($CARD_TYPE_CODE) } </CARD_TYPE_CODE>
  									}
  									{
  										for $CARD_TYPE_DESCRIPTION in $CARD_ROW/ns1:Column[upper-case(@name) = "DESCCATEGORIA"]
  										return
  										<CARD_TYPE_DESCRIPTION> { data($CARD_TYPE_DESCRIPTION) } </CARD_TYPE_DESCRIPTION>
  									}
  									{
  										for $LOGO in $CARD_ROW/ns1:Column[upper-case(@name) = "LOGO"]
  										return
  										<LOGO> { data($LOGO) } </LOGO>
  									}
  									{
  										for $PRODUCT_TYPE_DESCRIPTION in $CARD_ROW/ns1:Column[upper-case(@name) = "DESCR"]
  										return
  										<PRODUCT_TYPE_DESCRIPTION> { data($PRODUCT_TYPE_DESCRIPTION) } </PRODUCT_TYPE_DESCRIPTION>
  									}
  									{
  										for $CARD_STATUS_CODE in $CARD_ROW/ns1:Column[upper-case(@name) = "CODIGOESTADO"]
  										return
  										
  										if(string($CARD_STATUS_CODE/text()) != "") then (
  											<CARD_STATUS_CODE> { data($CARD_STATUS_CODE) } </CARD_STATUS_CODE>
  										) else ()
  									}
  									{
  										for $CARD_STATUS_DESCRIPTION in $CARD_ROW/ns1:Column[upper-case(@name) = "ESTADOPLASTICO"]
  										return
  										<CARD_STATUS_DESCRIPTION> { data($CARD_STATUS_DESCRIPTION) } </CARD_STATUS_DESCRIPTION>
  									}
  									{
  										for $BLOCK_CODE_1 in $CARD_ROW/ns1:Column[upper-case(@name) = "CODBLOQUE1"]
  										return
  										<BLOCK_CODE_1> { data($BLOCK_CODE_1) } </BLOCK_CODE_1>
  									}
  									{
  										for $BLOCK_CODE_2 in $CARD_ROW/ns1:Column[upper-case(@name) = "CODBLOQUE2"]
  										return
  										<BLOCK_CODE_2> { data($BLOCK_CODE_2) } </BLOCK_CODE_2>
  									}
  									{
  										for $CUTOFF_DATE in $CARD_ROW/ns1:Column[upper-case(@name) = "CICLO_FACTU"]
  										return
  										<CUTOFF_DATE> { data($CUTOFF_DATE) } </CUTOFF_DATE>
  									}
  									{
  										for $BALANCE_INFO in $outputParameters/ns1:RowSet/ns1:Row where $BALANCE_INFO/ns1:Column[upper-case(@name) = "NUMTARJETA"]/text() = $CARD_NUMBER
  										return(
  											<ns0:BALANCE_INFO>
  												{
  													for $ORG in $BALANCE_INFO/ns1:Column[upper-case(@name) = "ORG"]
  													return
  													<ORG>{ data($ORG) }</ORG>  													
  												}
  												{
  													for $ORG_TYPE in $BALANCE_INFO/ns1:Column[upper-case(@name) = "TIPOORG"]
  													return
  													<ORG_TYPE>{ data($ORG_TYPE) }</ORG_TYPE>  													
  												}
  												{
  													for $CURRENCY in $BALANCE_INFO/ns1:Column[upper-case(@name) = "CODMONEDA"]
  													return
  													<CURRENCY>{ data($CURRENCY) }</CURRENCY>  													
  												}
  												{
  													for $CREDIT_LIMIT in $BALANCE_INFO/ns1:Column[upper-case(@name) = "CRLIM"]
  													return
  													<CREDIT_LIMIT>{ data($CREDIT_LIMIT) }</CREDIT_LIMIT>  													
  												}
  												{
  													for $CURRENT_BALANCE in $BALANCE_INFO/ns1:Column[upper-case(@name) = "BALANCEACTUAL"]
  													return
  													<CURRENT_BALANCE>{ data($CURRENT_BALANCE) }</CURRENT_BALANCE>  													
  												}
  												{
  													for $CUTOFF_BALANCE in $BALANCE_INFO/ns1:Column[upper-case(@name) = "BILLED_BAL"]
  													return
  													<CUTOFF_BALANCE>{ data($CUTOFF_BALANCE) }</CUTOFF_BALANCE>  													
  												}
  												{
  													for $PURCHASE_AVAILABLE_AMOUNT in $BALANCE_INFO/ns1:Column[upper-case(@name) = "CRDISPO"]
  													return
  													<PURCHASE_AVAILABLE_AMOUNT>{ data($PURCHASE_AVAILABLE_AMOUNT) }</PURCHASE_AVAILABLE_AMOUNT>  													
  												}
  												{
  													for $AVAILABLE_WITHDRAWAL in $BALANCE_INFO/ns1:Column[upper-case(@name) = "CRDISPO_CASH"]
  													return
  													<AVAILABLE_WITHDRAWAL>{ data($AVAILABLE_WITHDRAWAL) }</AVAILABLE_WITHDRAWAL>  													
  												}
  												{
  													for $MIN_PAYMENT in $BALANCE_INFO/ns1:Column[upper-case(@name) = "PAGOMINIMO"]
  													return
  													<MIN_PAYMENT>{ data($MIN_PAYMENT) }</MIN_PAYMENT>  													
  												}
  											</ns0:BALANCE_INFO>
  										)
  									}
  								</ns0:CARD_INFO>
  							)
  						)
  					}
  				</ns0:ACCOUNT_INFO>
  			)
  		}
        </ns0:consultaInfoTarjetasPorClienteResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaInfoTarjetasClienteHNOut($outputParameters)
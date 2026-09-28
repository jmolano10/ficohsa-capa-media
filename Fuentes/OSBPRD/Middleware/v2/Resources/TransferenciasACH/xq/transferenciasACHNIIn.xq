(:: pragma bea:global-element-parameter parameter="$transferenciasACHRequest" element="ns2:transferenciasACHRequest" location="../xsd/transferenciasACHType.xsd" ::)
(:: pragma bea:global-element-return element="ns0:opTransferenciaIndividualACHSolicitud" location="../../../BusinessServices/CTS/transferencia/xsd/services.xsd" ::)

declare namespace ns0 = "http://service.srvaplcobistransferencia.ecobis.cobiscorp";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/transferenciasACHType";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACH/xq/transferenciasACHNIIn/";

declare function local:getServiceType($type as xs:string )
	as xs:string {
		if ($type = ("Savings","Checking")) then (
			"STRA"
		) else if ($type = "Loanpayment") then (
  			"SLOAN"
  		) else if ($type = "Creditca") then (
  			"SPTC"
  		) else ( 
  			""
  		)
};
declare function local:getProductType($type as xs:string )
	as xs:string {
		if ($type = ("Savings")) then (
			"AHO"
		) else if ($type = "Checking") then (
  			"CTE"
  		) else if ($type = "Loanpayment") then (
  			"CCA"
  		) else if ( $type = "Creditca") then (
  			"TCR"
  		)else (
  		"")
};
declare function local:getDebitCredit($data as xs:string )
	as xs:string {
		if (upper-case($data) = "DEBIT") then (
			"D"
		) else if (upper-case($data) = "CREDIT") then (
  			"C"
  		) else (
  		"")
};

declare function xf:transferenciasACHNIIn($transferenciasACHRequest as element(ns2:transferenciasACHRequest))
    as element(ns0:opTransferenciaIndividualACHSolicitud) {
        <ns0:opTransferenciaIndividualACHSolicitud>
            <ns1:contextoTransaccional>
                <ns1:codCanalOriginador>1</ns1:codCanalOriginador>
            </ns1:contextoTransaccional>
            <ns1:salienteIndividualACH>
                <ns1:tipoServicio>{ local:getServiceType (data($transferenciasACHRequest/ACCOUNT_TYPE)) }</ns1:tipoServicio>
                <ns1:cuentaRecibidor>
                    <ns1:codCuentaHabiente>{ data($transferenciasACHRequest/CREDIT_ACCOUNT) }</ns1:codCuentaHabiente>
                </ns1:cuentaRecibidor>
                <ns1:cuentaOriginador>
                    <ns1:codCuentaHabiente>{ data($transferenciasACHRequest/DEBIT_ACCOUNT) }</ns1:codCuentaHabiente>
                </ns1:cuentaOriginador>
                <ns1:monto>{ data($transferenciasACHRequest/TRANSFER_AMOUNT) }</ns1:monto>
                <ns1:bancoRecibidor>
                    <ns1:codigoAch>{ data($transferenciasACHRequest/DESTINATION_BANK) }</ns1:codigoAch>
                </ns1:bancoRecibidor>
                <ns1:concepto>{ data($transferenciasACHRequest/TRANSACTION_DESCRIPTION) }</ns1:concepto>
                <ns1:moneda>
                    <ns1:valSimboloMoneda>{ data($transferenciasACHRequest/CREDIT_CURRENCY) }</ns1:valSimboloMoneda>
                </ns1:moneda>
                <ns1:beneficiario>{ data($transferenciasACHRequest/BENEFICIARY_NAME) }</ns1:beneficiario>
                <ns1:idRecibidor>{ data($transferenciasACHRequest/BENEFICIARY_ID) }</ns1:idRecibidor>
                <ns1:productoRecibidor>
                    <ns1:codTipoProducto>{ local:getProductType( data($transferenciasACHRequest/ACCOUNT_TYPE)) }</ns1:codTipoProducto>
                </ns1:productoRecibidor>
                <ns1:monedaOperacion>
                    {
                        for $DEBIT_CREDIT in $transferenciasACHRequest/DEBIT_CREDIT
                        return
                            <ns1:valSimboloMoneda>{ local:getDebitCredit(data($DEBIT_CREDIT)) }</ns1:valSimboloMoneda>
                    }
                </ns1:monedaOperacion>
            </ns1:salienteIndividualACH>
        </ns0:opTransferenciaIndividualACHSolicitud>
};

declare variable $transferenciasACHRequest as element(ns2:transferenciasACHRequest) external;

xf:transferenciasACHNIIn($transferenciasACHRequest)
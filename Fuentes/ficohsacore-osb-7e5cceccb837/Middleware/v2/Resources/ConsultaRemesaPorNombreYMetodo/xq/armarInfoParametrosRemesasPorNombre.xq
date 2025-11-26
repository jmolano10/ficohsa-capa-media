(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaRemesaPorNombreYMetodo" element="ns1:consultaRemesaPorNombreYMetodo" location="../xsd/consultaRemesaPorNombreYMetodoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../BusinessServices/armarMensajeRecaudo/xsd/FLINK_OSB_K_RECAUDOS_REF_ONLINE_OSB_ARMAR_MENSAJE.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_K_RECAUDOS_REF_ONLINE/OSB_ARMAR_MENSAJE/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRemesaPorNombreYMetodoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRemesaPorNombreYMetodo/xq/armarInfoParametrosRemesasPorNombre/";

declare function xf:armarInfoParametrosRemesasPorNombre($requestHeader as element(ns0:RequestHeader),
    $consultaRemesaPorNombreYMetodo as element(ns1:consultaRemesaPorNombreYMetodo))
    as element(ns2:InputParameters) {
<ns2:InputParameters>
            {
                for $REMITTANCE_ID in $consultaRemesaPorNombreYMetodo/REMITTANCE_ID
                return
                    <ns2:CODIGO_CONTRATO>{ data($REMITTANCE_ID) }</ns2:CODIGO_CONTRATO>
            }
            <ns2:TIPO_OPERACION>3</ns2:TIPO_OPERACION>
            <ns2:TIPO_PARAM>REQ</ns2:TIPO_PARAM>
            <ns2:APLICACION>ENQ</ns2:APLICACION>
            <ns2:INFO>
                <ns2:DATA>
                    <ns2:NAME>UserName</ns2:NAME>
                    <ns2:VALUE>{ data($requestHeader/Authentication/UserName)}</ns2:VALUE>
                </ns2:DATA>
                <ns2:DATA>
                    <ns2:NAME>agreementContractID</ns2:NAME>
                    {
		                for $REMITTANCE_ID in $consultaRemesaPorNombreYMetodo/REMITTANCE_ID
		                return
                    	(<ns2:VALUE>{ data($REMITTANCE_ID) }</ns2:VALUE>)
                    }
                </ns2:DATA>
                <ns2:DATA>
                    <ns2:NAME>operationCode</ns2:NAME>
                    {
                        for $OPERATION_CODE in $consultaRemesaPorNombreYMetodo/OPERATION_CODE
                        return
                            <ns2:VALUE>{ data($OPERATION_CODE) }</ns2:VALUE>
                    }
                </ns2:DATA>
                <ns2:DATA>
                	<ns2:NAME>coreRunningDate</ns2:NAME>
                    {
						let $currentDateTime := fn:adjust-dateTime-to-timezone(fn:current-dateTime())
						let $strDateTime := fn-bea:dateTime-to-string-with-format("yyyyMMddHHmmss",$currentDateTime)
						return (
							<ns2:VALUE>{ $strDateTime }</ns2:VALUE>
						)					
					}
                </ns2:DATA>
                <ns2:DATA>
                	<ns2:NAME>transactionID</ns2:NAME>
                    {
						let $currentDateTime := fn:adjust-dateTime-to-timezone(fn:current-dateTime())
						let $strDateTime := fn-bea:dateTime-to-string-with-format("yyyyMMddHHmmss",$currentDateTime)
						return (
							<ns2:VALUE>{ concat("OSB",$strDateTime) }</ns2:VALUE>
						)					
					}
                </ns2:DATA>
                <ns2:DATA>
                    <ns2:NAME>branchCode</ns2:NAME>
                    {
                        for $BRANCH_CODE in $consultaRemesaPorNombreYMetodo/BRANCH_CODE
                        return
                            <ns2:VALUE>{ data($BRANCH_CODE) }</ns2:VALUE>
                    }
                </ns2:DATA>
                
              <!-- Nombre de la Persona Beneficiada -->
                <ns2:DATA>
                    <ns2:NAME>beneficiaryFullName</ns2:NAME>
                    {
                        for $BENEFICIARY_FIRSTNAME in $consultaRemesaPorNombreYMetodo/BENEFICIARY_FIRSTNAME,
                            $BENEFICIARY_MIDDLENAME in $consultaRemesaPorNombreYMetodo/BENEFICIARY_MIDDLENAME
                        return
                            <ns2:VALUE>{ normalize-space(concat(data($BENEFICIARY_FIRSTNAME), " ", data($BENEFICIARY_MIDDLENAME))) }</ns2:VALUE>
                    }
                </ns2:DATA>
                <ns2:DATA>
                    <ns2:NAME>beneficiaryFirstName</ns2:NAME>
                    {
                        for $BENEFICIARY_FIRSTNAME in $consultaRemesaPorNombreYMetodo/BENEFICIARY_FIRSTNAME
                        return
                            <ns2:VALUE>{ normalize-space(data($BENEFICIARY_FIRSTNAME)) }</ns2:VALUE>
                    }
                </ns2:DATA>
                <ns2:DATA>
                    <ns2:NAME>beneficiaryMiddlename</ns2:NAME>
                    {
                        for $BENEFICIARY_MIDDLENAME in $consultaRemesaPorNombreYMetodo/BENEFICIARY_MIDDLENAME
                        return
                            <ns2:VALUE>{ normalize-space(data($BENEFICIARY_MIDDLENAME)) }</ns2:VALUE>
                    }
                </ns2:DATA>
                
			<!-- Apellido de la Persona Beneficiada -->
                <ns2:DATA>
                    <ns2:NAME>beneficiaryFullSurname</ns2:NAME>
                    {
                        for $BENEFICIARY_FIRSTSURNAME in $consultaRemesaPorNombreYMetodo/BENEFICIARY_FIRSTSURNAME,
                            $BENEFICIARY_SECONDSURNAME in $consultaRemesaPorNombreYMetodo/BENEFICIARY_SECONDSURNAME
                        return
                            <ns2:VALUE>{ normalize-space(concat(data($BENEFICIARY_FIRSTSURNAME), " ", data($BENEFICIARY_SECONDSURNAME))) }</ns2:VALUE>
                    }
                </ns2:DATA>
                <ns2:DATA>
                    <ns2:NAME>beneficiaryFirstSurname</ns2:NAME>
                    {
                        for $BENEFICIARY_FIRSTSURNAME in $consultaRemesaPorNombreYMetodo/BENEFICIARY_FIRSTSURNAME
                            
                        return
                            <ns2:VALUE>{ normalize-space(data($BENEFICIARY_FIRSTSURNAME)) }</ns2:VALUE>
                    }
                </ns2:DATA>
                <ns2:DATA>
                    <ns2:NAME>beneficiarySecondSurname</ns2:NAME>
                    {
                        for $BENEFICIARY_SECONDSURNAME in $consultaRemesaPorNombreYMetodo/BENEFICIARY_SECONDSURNAME
                            
                        return
                            <ns2:VALUE>{ normalize-space(data($BENEFICIARY_SECONDSURNAME)) }</ns2:VALUE>
                    }
                </ns2:DATA>               
		
			<!-- Nombre de la Persona Remitente -->
                <ns2:DATA>
                    <ns2:NAME>senderFullName</ns2:NAME>
                    {
                        for $REMITTER_FIRSTNAME in $consultaRemesaPorNombreYMetodo/REMITTER_FIRSTNAME,
                            $REMITTER_MIDDLENAME in $consultaRemesaPorNombreYMetodo/REMITTER_MIDDLENAME
                        return
                            <ns2:VALUE>{ normalize-space(concat(data($REMITTER_FIRSTNAME), " ", data($REMITTER_MIDDLENAME))) }</ns2:VALUE>
                    }
                </ns2:DATA>
                <ns2:DATA>
                    <ns2:NAME>senderFirstName</ns2:NAME>
                    {
                        for $REMITTER_FIRSTNAME in $consultaRemesaPorNombreYMetodo/REMITTER_FIRSTNAME
                        return
                            <ns2:VALUE>{ normalize-space(data($REMITTER_FIRSTNAME)) }</ns2:VALUE>
                    }
                </ns2:DATA>
                <ns2:DATA>
                    <ns2:NAME>senderMiddlename</ns2:NAME>
                    {
                        for $REMITTER_MIDDLENAME in $consultaRemesaPorNombreYMetodo/REMITTER_MIDDLENAME
                        return
                            <ns2:VALUE>{ normalize-space(data($REMITTER_MIDDLENAME)) }</ns2:VALUE>
                    }
                </ns2:DATA>
                
			<!-- Apellido de la Persona Remitente -->
                <ns2:DATA>
                    <ns2:NAME>senderFullSurname</ns2:NAME>
                    {
                        for $REMITTER_FIRSTSURNAME in $consultaRemesaPorNombreYMetodo/REMITTER_FIRSTSURNAME,
                            $REMITTER_SECONDSURNAME in $consultaRemesaPorNombreYMetodo/REMITTER_SECONDSURNAME
                        return
                            <ns2:VALUE>{ normalize-space(concat(data($REMITTER_FIRSTSURNAME), " ", data($REMITTER_SECONDSURNAME))) }</ns2:VALUE>
                    }
                </ns2:DATA>
                <ns2:DATA>
                    <ns2:NAME>senderFirstSurname</ns2:NAME>
                    {
                        for $REMITTER_FIRSTSURNAME in $consultaRemesaPorNombreYMetodo/REMITTER_FIRSTSURNAME                            
                        return
                            <ns2:VALUE>{ normalize-space(data($REMITTER_FIRSTSURNAME)) }</ns2:VALUE>
                    }
                </ns2:DATA>
                <ns2:DATA>
                    <ns2:NAME>senderSecondSurname</ns2:NAME>
                    {
                        for $REMITTER_SECONDSURNAME in $consultaRemesaPorNombreYMetodo/REMITTER_SECONDSURNAME
                        return
                            <ns2:VALUE>{ normalize-space(data($REMITTER_SECONDSURNAME)) }</ns2:VALUE>
                    }
                </ns2:DATA>
            </ns2:INFO>
        </ns2:InputParameters>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $consultaRemesaPorNombreYMetodo as element(ns1:consultaRemesaPorNombreYMetodo) external;

xf:armarInfoParametrosRemesasPorNombre($requestHeader,
    $consultaRemesaPorNombreYMetodo)

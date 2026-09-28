xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/MasterDataPA/conInfoClienteTE/xsd/conInfoClienteTE_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaDemograficaProspectoResponse" location="../xsd/consultaDemograficaProspectoTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDemograficaProspectoPA/xq/consultaDemograficaProspectoPAOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDemograficaProspectoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conInfoClienteTE";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaEquivalenciasCatalogos";

declare function valorCatalogoAPPToOSB($valor as xs:string,
	$aplicacion as xs:string,
	$catalogoId as xs:string,
	$equivalencias as element(*)
) as xs:string {
	let $retorno := fn:string($equivalencias/ns2:EQUIVALENCIA[ns2:CATALOGO_ID = $catalogoId and 
															  ns2:APLICACION_DESC = $aplicacion and 
															  ns2:EQUIVALENCIA_DESC = $valor]/ns2:VALOR_DESC/text())
	return
		if($retorno != "") then (
			$retorno
		) else (
			$valor
		)
};

declare function xf:consultaDemograficaProspectoPAOut($outputParameters as element(ns1:OutputParameters), $ptEquivalencias as element(*))
    as element(ns0:consultaDemograficaProspectoResponse) {
    	let $rowSet := $outputParameters/ns1:RowSet[1]
    	let $row := $rowSet/ns1:Row[1]
    	return
        <ns0:consultaDemograficaProspectoResponse>
        	<CUSTOMER_NAMES>
        		{
        			for $firstName in $row/ns1:Column[@name = "PrimerNombre"]
        				return
        					<FIRST_NAME>{ fn:data($firstName) }</FIRST_NAME>
        		}
        		{
        			for $middleName in $row/ns1:Column[@name = "SegundoNombre"]
        				return
        					<MIDDLE_NAME>{ fn:data($middleName) }</MIDDLE_NAME>
        		}
        		{
        			for $firstSurname in $row/ns1:Column[@name = "PrimerApellido"]
        				return
        					<FIRST_SURNAME>{ fn:data($firstSurname) }</FIRST_SURNAME>
        		}
        		{
        			for $secondSurname in $row/ns1:Column[@name = "SegundoApellido"]
        				return
        					<SECOND_SURNAME>{ fn:data($secondSurname) }</SECOND_SURNAME>
        		}
        	</CUSTOMER_NAMES>
        	{
        		for $birthDate in $row/ns1:Column[@name = "FechaNacimiento"]
        			return
        				<BIRTH_DATE>
        					{ 
        						if (xs:string($birthDate) != "") then (
        							fn-bea:dateTime-to-string-with-format("yyyyMMdd", fn:data($birthDate))
        						) else ("")
        				 	}
        				 </BIRTH_DATE>
        	}
        	{
        		for $birthPlace in $row/ns1:Column[@name = "LugarNacimiento"]
        			return
        				<BIRTH_PLACE>{ fn:data($birthPlace) }</BIRTH_PLACE>
        	}
        	{
        		for $gender in $row/ns1:Column[@name = "Genero"]
        			return
        				<GENDER>{ valorCatalogoAPPToOSB(fn:data($gender), 'MASTERDATAPA', '1', $ptEquivalencias) }</GENDER>
        	}
        	{
        		for $idIssueDate in $row/ns1:Column[@name = "FechaEmisionID"]
        			return
        				<ID_ISSUE_DATE>
        					{
        						if (xs:string($idIssueDate) != "") then (
        					 		fn-bea:dateTime-to-string-with-format("yyyyMMdd", fn:data($idIssueDate)) 
        						) else ("")
        					}
        				</ID_ISSUE_DATE>
        	}
        	{
        		for $idExpirationDate in $row/ns1:Column[@name = "FechaExpiracionID"]
        			return
        				<ID_EXPIRATION_DATE>
        					{
        						if (xs:string($idExpirationDate) != "") then (
        							fn-bea:dateTime-to-string-with-format("yyyyMMdd", fn:data($idExpirationDate))
        						) else ("")
        					}
        				</ID_EXPIRATION_DATE>
        	}
        </ns0:consultaDemograficaProspectoResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $ptEquivalencias as element() external;

xf:consultaDemograficaProspectoPAOut($outputParameters, $ptEquivalencias)
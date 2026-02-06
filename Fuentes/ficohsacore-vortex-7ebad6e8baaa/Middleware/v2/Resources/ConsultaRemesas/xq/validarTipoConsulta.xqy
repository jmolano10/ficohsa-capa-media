xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaRemesas1" element="ns0:consultaRemesas" location="../xsd/consultaRemesasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRemesasTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/remesas/ConsultaRemesas/validarTipoConsulta/";

declare function validaNombreYApellido($firstName as xs:string, $middleName as xs:string, $firstSurName as xs:string, $secondSurName as xs:string) as xs:boolean {
	($firstName != "" or $middleName != "") and ($firstSurName != "" or $secondSurName != "")
};

declare function xf:validarTipoConsulta($consultaRemesas1 as element(ns0:consultaRemesas))
    as xs:string {
        if ( fn:string($consultaRemesas1/REMITTANCE_ID/text()) != "" ) then (
        	"ID_BASED"
        ) else if ( validaNombreYApellido(
        			fn:string($consultaRemesas1/REMITTER_FIRSTNAME/text()),
        			fn:string($consultaRemesas1/REMITTER_MIDDLENAME/text()),
        			fn:string($consultaRemesas1/REMITTER_FIRSTSURNAME/text()),
        			fn:string($consultaRemesas1/REMITTER_SECONDSURNAME/text())
        			) or
        			validaNombreYApellido(
        			fn:string($consultaRemesas1/BENEFICIARY_FIRSTNAME/text()),
        			fn:string($consultaRemesas1/BENEFICIARY_MIDDLENAME/text()),
        			fn:string($consultaRemesas1/BENEFICIARY_FIRSTSURNAME/text()),
        			fn:string($consultaRemesas1/BENEFICIARY_SECONDSURNAME/text())
        			)) then (
        			"NAME_BASED"
        	   ) else (
        	   		""
        	   )
};

declare variable $consultaRemesas1 as element(ns0:consultaRemesas) external;

xf:validarTipoConsulta($consultaRemesas1)
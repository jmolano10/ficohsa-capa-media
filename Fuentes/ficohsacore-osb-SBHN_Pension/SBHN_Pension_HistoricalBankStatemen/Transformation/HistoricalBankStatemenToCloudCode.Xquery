<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/honduras/pension";
(:: import schema at "../Schemas/HistoricalBankStatemenTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../../SBHN_Pension_Commons/Schemas/CloudCodeTypes.xsd" ::)

declare variable $historicalBankStatemen as element() (:: schema-element(ns1:historicalBankStatement) ::) external;

declare function local:obtenerXMLDocumentos()
    as element(*){
    	        <LEGAL_ID_TYPES>
			<LEGAL_ID_TYPE name="1">CC</LEGAL_ID_TYPE>
                        <LEGAL_ID_TYPE name="2">CAR</LEGAL_ID_TYPE>
			<LEGAL_ID_TYPE name="4" >PAS</LEGAL_ID_TYPE>			
                        <LEGAL_ID_TYPE name="5">NIT</LEGAL_ID_TYPE>
		</LEGAL_ID_TYPES>
    };

declare function local:func($historicalBankStatemen as element() (:: schema-element(ns1:historicalBankStatement) ::)) as element() (:: schema-element(ns2:estadoCuentasHistoricos) ::) {
      <ns2:estadoCuentasHistoricos>
        {
          let $codEquivalente := string(local:obtenerXMLDocumentos()/LEGAL_ID_TYPE[@name = data($historicalBankStatemen/IdentificationType)])
          return
          <ns2:tipoIdentificacion>{($codEquivalente, data($historicalBankStatemen/IdentificationType))[. != ''][1]}</ns2:tipoIdentificacion>
        }
        <ns2:numeroIdentificacion>{fn:data($historicalBankStatemen/IdentificationNumber)}</ns2:numeroIdentificacion>
        <ns2:fechaInicio>{fn:data($historicalBankStatemen/StartDate)}</ns2:fechaInicio>
        <ns2:fechaFinal>{fn:data($historicalBankStatemen/EndDate)}</ns2:fechaFinal>
      </ns2:estadoCuentasHistoricos>
};

local:func($historicalBankStatemen)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/HistoricalBankStatemenTypes.xsd">
            <con:schema ref="SBHN_Pension_HistoricalBankStatemen/Schemas/HistoricalBankStatemenTypes"/>
        </con:importSchema>
        <con:importSchema location="../../SBHN_Pension_Commons/Schemas/CloudCodeTypes.xsd">
            <con:schema ref="SBHN_Pension_Commons/Schemas/CloudCodeTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>
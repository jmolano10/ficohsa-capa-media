xquery version "2004-draft" encoding "Cp1252";
(:: pragma  type="xs:anyType" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Generales/xq/convertirTipoSobregiro/";

declare function xf:convertirTipoSobregiro($region as xs:string
	)
as element(*) {
	let $conversionList := (
	<REGIONS>
		<REGION>
			<ID>HN01</ID>
			<CONVERSIONS>
				<CONVERSION>
					<BUSINESS_VALUE>21072</BUSINESS_VALUE>
					<PROXY_VALUE>SOBAUTH</PROXY_VALUE>
				</CONVERSION>
				<CONVERSION>
					<BUSINESS_VALUE>21073</BUSINESS_VALUE>
					<PROXY_VALUE>SOBNAUT</PROXY_VALUE>
				</CONVERSION>
				<CONVERSION>
					<BUSINESS_VALUE>21074</BUSINESS_VALUE>
					<PROXY_VALUE>ADLEFEC</PROXY_VALUE>
				</CONVERSION>
			</CONVERSIONS>
		</REGION>
	</REGIONS>
	)
	return fn-bea:fail-over($conversionList/REGION[ID = $region],"")
};

declare variable $region as xs:string external;

xf:convertirTipoSobregiro($region)
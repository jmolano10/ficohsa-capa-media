(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns3:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$registrarRTE" element="ns0:registrarRTE" location="../../xsds/RegistrarRTE/RegistrarRTE.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns2:OutputParameters" location="../../xsds/RegistrarRTE/ConsultarInfoClientesRTE/FLINK_OSB_CONSULTAR_INFO_CLIENTE_RTE.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadeclienteResponse" element="ns1:ConsultadeclienteResponse" location="../../xsds/ConsultasCliente/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadeclienteResponseBEHALF" element="ns1:ConsultadeclienteResponse" location="../../xsds/ConsultasCliente/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadeclienteResponseBEN" element="ns1:ConsultadeclienteResponse" location="../../xsds/ConsultasCliente/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-return element="ns1:RegistrodeRTE" location="../../xsds/RegistroRTE/XMLSchema_-102414330.xsd" ::)

declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_CONSULTAR_INFO_CLIENTE_RTE/";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/registrarRTETypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/RegistrarRTE/RegistrarRTEIn/";

(: Se encarga de partir un string en una secuencia de string de determinado tamaño :)
declare function splitString($String as xs:string?, $length as xs:integer) as xs:string* {
  if (exists($String) and string-length($String) > $length) then 
    (substring($String,1,$length), splitString(substring($String,$length+1),$length)) 
  else $String
};

(: Se encarga de verificar si el primer parámetro es diferente de vacío devulve vacío, en caso contrario, devuelve el segundo parámetro :)
declare function sendValue($param1 as xs:string, $param2 as xs:string) as xs:string {
  let $nuevoParam1 := fn-bea:trim(fn:replace(fn:replace(fn:string($param1),"!", " "),"\|"," "))
  return
	  if(fn:string($nuevoParam1) = "") then (
	  	remove-symbol(fn:string($param2))
	  ) else (
	  	""
	  )
};

(:: Calcula la posición de la dirección del tipo deseado dentro del ADRRESSTYPE :)
declare function index-of-type( $addresstype as xs:string?, $type as xs:string?) 
	as xs:integer?{
	let $result := 
		for $item at $i in fn:tokenize($addresstype, '!!')
		return
			if(fn:string($item) = $type) then (
				$i
			) else ()
	return 
		if (fn:string($result[1]) = "" or $result[1] < 1) then (
			-1
		)  else (
			$result[1]
		)
};

(:: Reemplaza las letras acentuadas, comas, puntos y otros simbolos :)
declare function remove-symbol( $cadena as xs:string ) as xs:string?{
	if(fn:string($cadena) != "") then (
		fn:translate($cadena, 'áéíóúñâêîôûàèìòùÁÉÍÓÚÑÂÊÎÔÛÀÈÌÒÙ,;{}[][´}^`%$#|@\¬¿?~¿¡!()-_','aeiounaeiouaeiouAEIOUNAEIOUAEIOU')
	) else (
		""
	)
};

declare function xf:RegistrarRTEIn($autenticacionRequestHeader as element(ns3:AutenticacionRequestHeader),
    $registrarRTE as element(ns0:registrarRTE),
    $outputParameters as element(ns2:OutputParameters),
    $uuid as xs:string,
    $id_trx as xs:string,
    $isIDClient as xs:string,
    $isBEHALFClient as xs:string,
    $isBENClient as xs:string,
    $RTETXNTYPE as xs:string,
    $typeOfPersonID as xs:string,
    $typeOfPersonBEHALF as xs:string,
    $typeOfPersonBEN as xs:string,
    $isServiceAccount as xs:string,
    $consultadeclienteResponse as element(ns1:ConsultadeclienteResponse),
    $consultadeclienteResponseBEHALF as element(ns1:ConsultadeclienteResponse),
    $consultadeclienteResponseBEN as element(ns1:ConsultadeclienteResponse))
    as element(ns1:RegistrodeRTE) {
        <ns1:RegistrodeRTE>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <messageId>{ $uuid }</messageId>
            </OfsFunction>
            <FICORTERTEFORMWSType>
                <TellerTransID>{ fn:string($id_trx) }</TellerTransID>
                <RteTxnType>{ $RTETXNTYPE }</RteTxnType>
                <gORIGINRESOURCES>
                {
                	for $OriginandAux in splitString(fn-bea:trim(fn:string($registrarRTE/ORIGINAND_TARGET/text())),48)
                		return
                			if( fn:string($OriginandAux) != "" ) then (
                				<OriginandTarget>{ remove-symbol(fn:string($OriginandAux)) }</OriginandTarget>
                			) else ()
                }  
                </gORIGINRESOURCES>
                <OwnerTXN>{ remove-symbol(data($registrarRTE/OWNER_TXN)) }</OwnerTXN>
                
                (:: En outputParameters: Posición 1 = Info de ID_NUMBER :)
                <TypeID>{ sendValue(fn:string($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LEGALDOCNAME/text()), fn-bea:trim(fn:string($outputParameters/ns2:TIPO_ID/ns2:ITEM[1]/text()))) }</TypeID>
                <IDNumber>{ fn-bea:trim(fn:string($outputParameters/ns2:NUMERO_ID/ns2:ITEM[1]/text())) }</IDNumber>
                {
                	if( $isIDClient != "YES")  then (
		                <FullName>{ sendValue(fn:string($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/SHORTNAME/text()), fn-bea:trim(fn:string($outputParameters/ns2:NOMBRE_COMPLETO/ns2:ITEM[1]/text()))) }</FullName>,
		                <DateofBirth>{ sendValue(fn:string($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/DATEOFBIRTH/text()), fn-bea:trim(fn:string($outputParameters/ns2:FECHA_NACIMIENTO/ns2:ITEM[1]/text()))) }</DateofBirth>,
		                <Gender>{ sendValue(fn:string($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/GENDER/text()), fn-bea:trim(fn:string($outputParameters/ns2:GENERO/ns2:ITEM[1]/text()))) }</Gender>, 
		                <Country>{ sendValue(fn:string($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/COUNTRYCODE/text()), fn-bea:trim(fn:string($outputParameters/ns2:PAIS/ns2:ITEM[1]/text()))) }</Country>,
		                <Nationality>{ sendValue(fn:string($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/COUNTRYCODE/text()), fn-bea:trim(fn:string($outputParameters/ns2:NACIONALIDAD/ns2:ITEM[1]/text()))) }</Nationality>,
		                <Department>{ sendValue(fn:string($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/STATECODE/text()), fn-bea:trim(fn:string($outputParameters/ns2:DEPARTAMENTO/ns2:ITEM[1]/text()))) }</Department>,
		                <Municipality>{ sendValue(fn:string($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/CITYCODE/text()), fn-bea:trim(fn:string($outputParameters/ns2:MUNICIPIO/ns2:ITEM[1]/text()))) }</Municipality>
		                
		            ) else if( upper-case($typeOfPersonID) = "LEGAL") then (
		            	<DateofBirth>{ sendValue(fn:string($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/DATEOFBIRTH/text()), fn-bea:trim(fn:string($outputParameters/ns2:FECHA_NACIMIENTO/ns2:ITEM[1]/text()))) }</DateofBirth>,
		            	<Gender>{ sendValue(fn:string($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/GENDER/text()), fn-bea:trim(fn:string($outputParameters/ns2:GENERO/ns2:ITEM[1]/text()))) }</Gender>
		            	
                	) else ()
                }
                <HomeAddress>{ sendValue(fn:string($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/ADDRESSLINE1/text()), fn-bea:trim(fn:string($outputParameters/ns2:DIRECCION/ns2:ITEM[1]/text()))) }</HomeAddress>
                {
                	if( $isIDClient != "YES")  then (
                		let $homeIndex := index-of-type(fn:string($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/ADDRESSTYPE/text()), "1")
                		let $homePhone := fn:tokenize(fn:string($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/PHONE/text()),"\|\|")[$homeIndex]
                		return
	                		<ResidenceNumber>{ substring(sendValue(fn:string($homePhone), fn-bea:trim(fn:string($outputParameters/ns2:TELEFONO_DOMICILIO/ns2:ITEM[1]/text()))),1,8) }</ResidenceNumber>,
	                  		<Profession>{ sendValue(fn:string($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/PROFESSIONORTRADE/text()), fn-bea:trim(fn:string($outputParameters/ns2:PROFESION/ns2:ITEM[1]/text()))) }</Profession>,
	                		<CompanyName>{ sendValue(fn:string($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/EMPLOYERSNAME/text()), fn:substring(fn-bea:trim(fn:string($outputParameters/ns2:LUGAR_TRABAJO/ns2:ITEM[1]/text())), 1, 25)) }</CompanyName>
                		
		            ) else if( upper-case($typeOfPersonID) = "LEGAL") then (
		            	<Profession>{ sendValue(fn:string($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/PROFESSIONORTRADE/text()), fn-bea:trim(fn:string($outputParameters/ns2:PROFESION/ns2:ITEM[1]/text()))) }</Profession>,
                		<CompanyName>{ sendValue(fn:string($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/EMPLOYERSNAME/text()), fn:substring(fn-bea:trim(fn:string($outputParameters/ns2:LUGAR_TRABAJO/ns2:ITEM[1]/text())), 1, 25)) }</CompanyName>
		            	
                	) else ()
                }
                {
	                let $workIndex := index-of-type(fn:string($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/ADDRESSTYPE/text()), "2")
	                let $workPhone := fn:tokenize(fn:string($consultadeclienteResponse/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/PHONE/text()),"\|\|")[$workIndex]
	                return
	                	<WorkPhone>{ substring(sendValue(fn:string($workPhone), fn-bea:trim(fn:string($outputParameters/ns2:TELEFONO_TRABAJO/ns2:ITEM[1]/text()))),1,8) }</WorkPhone>
                }
                <RelationwithBeneficiary>{ remove-symbol(data($registrarRTE/RELATION_WITH_BENEFICIARY)) }</RelationwithBeneficiary>
                
				(:: En outputParameters: Posición 2 = Info de BEHALF_ID_NUMBER :)
				{
					if( $isServiceAccount = "YES" ) then (
						<BehalfGender>{ sendValue(fn:string($consultadeclienteResponseBEHALF/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/GENDER/text()), fn-bea:trim(fn:string($outputParameters/ns2:GENERO/ns2:ITEM[2]/text()))) }</BehalfGender>,
		        		<BehalfProf>{ sendValue(fn:string($consultadeclienteResponseBEHALF/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/PROFESSIONORTRADE/text()), fn-bea:trim(fn:string($outputParameters/ns2:PROFESION/ns2:ITEM[2]/text()))) }</BehalfProf>,
		        		<BehalfRelWithBen>{ remove-symbol(data($registrarRTE/BEHALF_REL_WITH_BEN)) }</BehalfRelWithBen>
					) else (
		                <BehalfTypeID>{ sendValue(fn:string($consultadeclienteResponseBEHALF/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LEGALDOCNAME/text()), fn-bea:trim(fn:string($outputParameters/ns2:TIPO_ID/ns2:ITEM[2]/text()))) }</BehalfTypeID>,
		                <BehalfIDNumber>{ fn-bea:trim(fn:string($outputParameters/ns2:NUMERO_ID/ns2:ITEM[2]/text())) }</BehalfIDNumber>,
                	
	                	if( $isBEHALFClient != "YES")  then (
			                <BehalfFullName>{ sendValue(fn:string($consultadeclienteResponseBEHALF/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/SHORTNAME/text()), fn-bea:trim(fn:string($outputParameters/ns2:NOMBRE_COMPLETO/ns2:ITEM[2]/text()))) }</BehalfFullName>,
			                <BehalfGender>{ sendValue(fn:string($consultadeclienteResponseBEHALF/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/GENDER/text()), fn-bea:trim(fn:string($outputParameters/ns2:GENERO/ns2:ITEM[2]/text()))) }</BehalfGender>,
			                <BehalfCountry>{ sendValue(fn:string($consultadeclienteResponseBEHALF/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/COUNTRYCODE/text()), fn-bea:trim(fn:string($outputParameters/ns2:PAIS/ns2:ITEM[2]/text()))) }</BehalfCountry>,
			                <BehalfNationality>{ sendValue(fn:string($consultadeclienteResponseBEHALF/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/COUNTRYCODE/text()), fn-bea:trim(fn:string($outputParameters/ns2:NACIONALIDAD/ns2:ITEM[2]/text()))) }</BehalfNationality>,
			                <BehalfDept>{ sendValue(fn:string($consultadeclienteResponseBEHALF/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/STATECODE/text()), fn-bea:trim(fn:string($outputParameters/ns2:DEPARTAMENTO/ns2:ITEM[2]/text()))) }</BehalfDept>,
			                <BehalfMunicipality>{ sendValue(fn:string($consultadeclienteResponseBEHALF/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/CITYCODE/text()), fn-bea:trim(fn:string($outputParameters/ns2:MUNICIPIO/ns2:ITEM[2]/text()))) }</BehalfMunicipality>
			                        
			            ) else if( upper-case($typeOfPersonBEHALF) = "LEGAL") then (
			            	<BehalfGender>{ sendValue(fn:string($consultadeclienteResponseBEHALF/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/GENDER/text()), fn-bea:trim(fn:string($outputParameters/ns2:GENERO/ns2:ITEM[2]/text()))) }</BehalfGender>
			            	
	                	) else (),
                
		                <BehalfFullAddress>{ sendValue(fn:string($consultadeclienteResponseBEHALF/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/ADDRESSLINE1/text()), fn-bea:trim(fn:string($outputParameters/ns2:DIRECCION/ns2:ITEM[2]/text()))) }</BehalfFullAddress>,
		                
	                	if( $isBEHALFClient != "YES")  then (
		                	let $homeIndex := index-of-type(fn:string($consultadeclienteResponseBEHALF/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/ADDRESSTYPE/text()), "1")
	                		let $homePhone := fn:tokenize(fn:string($consultadeclienteResponseBEHALF/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/PHONE/text()),"\|\|")[$homeIndex]
	                		return     
								<BehalfHomeTel>{ substring(sendValue(fn:string($homePhone), fn-bea:trim(fn:string($outputParameters/ns2:TELEFONO_DOMICILIO/ns2:ITEM[2]/text()))),1,8) }</BehalfHomeTel>,
				        		<BehalfProf>{ sendValue(fn:string($consultadeclienteResponseBEHALF/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/PROFESSIONORTRADE/text()), fn-bea:trim(fn:string($outputParameters/ns2:PROFESION/ns2:ITEM[2]/text()))) }</BehalfProf>
			                        
			            ) else if( upper-case($typeOfPersonBEHALF) = "LEGAL") then (
			            	<BehalfProf>{ sendValue(fn:string($consultadeclienteResponseBEHALF/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/PROFESSIONORTRADE/text()), fn-bea:trim(fn:string($outputParameters/ns2:PROFESION/ns2:ITEM[2]/text()))) }</BehalfProf>
			            	
	                	) else (),
		                
	                	let $sectorIndex := index-of-type(fn:string($consultadeclienteResponseBEHALF/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/SECTORIZATIONTYPE/text()), "SB13")
	                	let $economicAct := fn:tokenize(fn:string($consultadeclienteResponseBEHALF/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/SECTORIZATIONCODE/text()),"!!")[$sectorIndex]
	                	return
	                		<BehalfEconomicAct>{ sendValue(fn:string($economicAct), fn-bea:trim(fn:string($outputParameters/ns2:ACTIVIDAD_ECONOMICA/ns2:ITEM[2]/text()))) }</BehalfEconomicAct>,
		                
		                <BehalfRelWithBen>{ remove-symbol(data($registrarRTE/BEHALF_REL_WITH_BEN)) }</BehalfRelWithBen>
		        	)
                }
				(:: En outputParameters: Posición 3 = Info de BEN_ID_NUMBER :)
				{
					if( $isServiceAccount = "YES" ) then (
						<BenGender>{ sendValue(fn:string($consultadeclienteResponseBEN/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/GENDER/text()), fn-bea:trim(fn:string($outputParameters/ns2:GENERO/ns2:ITEM[3]/text()))) }</BenGender>,
						let $workIndex := index-of-type(fn:string($consultadeclienteResponseBEN/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/ADDRESSTYPE/text()), "2")
                		let $workPhone := fn:tokenize(fn:string($consultadeclienteResponseBEN/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/PHONE/text()),"\|\|")[$workIndex]
                		return
							<BenWorkTel>{ substring(sendValue(fn:string($workPhone), fn-bea:trim(fn:string($outputParameters/ns2:TELEFONO_DOMICILIO/ns2:ITEM[3]/text()))),1,8) }</BenWorkTel>,
							<BenProfession>{ sendValue(fn:string($consultadeclienteResponseBEN/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/PROFESSIONORTRADE/text()), fn-bea:trim(fn:string($outputParameters/ns2:PROFESION/ns2:ITEM[3]/text()))) }</BenProfession>
					) else (
		                <BenTypeOfID>{ sendValue(fn:string($consultadeclienteResponseBEN/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LEGALDOCNAME/text()), fn-bea:trim(fn:string($outputParameters/ns2:TIPO_ID/ns2:ITEM[3]/text()))) }</BenTypeOfID>,
		                <BenIDNumber>{ fn-bea:trim(fn:string($outputParameters/ns2:NUMERO_ID/ns2:ITEM[3]/text())) }</BenIDNumber>,
		                
	                	if( $isBENClient != "YES")  then (
			                <BenFullName>{ sendValue(fn:string($consultadeclienteResponseBEN/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/SHORTNAME/text()), fn-bea:trim(fn:string($outputParameters/ns2:NOMBRE_COMPLETO/ns2:ITEM[3]/text()))) }</BenFullName>,
			                <BenGender>{ sendValue(fn:string($consultadeclienteResponseBEN/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/GENDER/text()), fn-bea:trim(fn:string($outputParameters/ns2:GENERO/ns2:ITEM[3]/text()))) }</BenGender>,
			                <BenCountry>{ sendValue(fn:string($consultadeclienteResponseBEN/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/COUNTRYCODE/text()), fn-bea:trim(fn:string($outputParameters/ns2:PAIS/ns2:ITEM[3]/text()))) }</BenCountry>,
			                <BenNationality>{ sendValue(fn:string($consultadeclienteResponseBEN/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/COUNTRYCODE/text()), fn-bea:trim(fn:string($outputParameters/ns2:NACIONALIDAD/ns2:ITEM[3]/text()))) }</BenNationality>,
			                <BenDepartment>{ sendValue(fn:string($consultadeclienteResponseBEN/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/STATECODE/text()), fn-bea:trim(fn:string($outputParameters/ns2:DEPARTAMENTO/ns2:ITEM[3]/text()))) }</BenDepartment>,
			                <BenMunicipality>{ sendValue(fn:string($consultadeclienteResponseBEN/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/CITYCODE/text()), fn-bea:trim(fn:string($outputParameters/ns2:MUNICIPIO/ns2:ITEM[3]/text()))) }</BenMunicipality>
			                        
			            ) else if( upper-case($typeOfPersonBEN) = "LEGAL") then (
			            	<BenGender>{ sendValue(fn:string($consultadeclienteResponseBEN/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/GENDER/text()), fn-bea:trim(fn:string($outputParameters/ns2:GENERO/ns2:ITEM[3]/text()))) }</BenGender>
			            	
	                	) else (),
		                
		                <BenFullAddress>{ sendValue(fn:string($consultadeclienteResponseBEN/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/ADDRESSLINE1/text()), fn-bea:trim(fn:string($outputParameters/ns2:DIRECCION/ns2:ITEM[3]/text()))) }</BenFullAddress>,
		                
	                	let $workIndex := index-of-type(fn:string($consultadeclienteResponseBEN/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/ADDRESSTYPE/text()), "2")
            			let $workPhone := fn:tokenize(fn:string($consultadeclienteResponseBEN/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/PHONE/text()),"\|\|")[$workIndex]
            			return
	                		<BenWorkTel>{ substring(sendValue(fn:string($workPhone), fn-bea:trim(fn:string($outputParameters/ns2:TELEFONO_DOMICILIO/ns2:ITEM[3]/text()))),1,8) }</BenWorkTel>,
		                
	                	if( $isBENClient != "YES")  then (
	                		<BenProfession>{ sendValue(fn:string($consultadeclienteResponseBEN/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/PROFESSIONORTRADE/text()), fn-bea:trim(fn:string($outputParameters/ns2:PROFESION/ns2:ITEM[3]/text()))) }</BenProfession>                
			                        
			            ) else if( upper-case($typeOfPersonBEN) = "LEGAL") then (
			            	<BenProfession>{ sendValue(fn:string($consultadeclienteResponseBEN/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/PROFESSIONORTRADE/text()), fn-bea:trim(fn:string($outputParameters/ns2:PROFESION/ns2:ITEM[3]/text()))) }</BenProfession>
			            	
	                	) else (),
		                
		                let $sectorIndex := index-of-type(fn:string($consultadeclienteResponseBEN/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/SECTORIZATIONTYPE/text()), "SB13")
	                	let $economicAct := fn:tokenize(fn:string($consultadeclienteResponseBEN/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/SECTORIZATIONCODE/text()),"!!")[$sectorIndex]
	                	return
		                	<BenEconomicAct>{ sendValue(fn:string($economicAct), fn-bea:trim(fn:string($outputParameters/ns2:ACTIVIDAD_ECONOMICA/ns2:ITEM[3]/text()))) }</BenEconomicAct>
		    	)
		    }             
            </FICORTERTEFORMWSType>
        </ns1:RegistrodeRTE>
};

declare variable $autenticacionRequestHeader as element(ns3:AutenticacionRequestHeader) external;
declare variable $registrarRTE as element(ns0:registrarRTE) external;
declare variable $outputParameters as element(ns2:OutputParameters) external;
declare variable $uuid as xs:string external;
declare variable $id_trx as xs:string external;
declare variable $isIDClient as xs:string external;
declare variable $isBEHALFClient as xs:string external;
declare variable $isBENClient as xs:string external;
declare variable $RTETXNTYPE as xs:string external;
declare variable $typeOfPersonID as xs:string external;
declare variable $typeOfPersonBEHALF as xs:string external;
declare variable $typeOfPersonBEN as xs:string external;
declare variable $isServiceAccount as xs:string external;
declare variable $consultadeclienteResponse as element(ns1:ConsultadeclienteResponse) external;
declare variable $consultadeclienteResponseBEHALF as element(ns1:ConsultadeclienteResponse) external;
declare variable $consultadeclienteResponseBEN as element(ns1:ConsultadeclienteResponse) external;

xf:RegistrarRTEIn($autenticacionRequestHeader,
    $registrarRTE,
    $outputParameters,
    $uuid,
    $id_trx,
    $isIDClient,
    $isBEHALFClient,
    $isBENClient,
    $RTETXNTYPE,
    $typeOfPersonID,
    $typeOfPersonBEHALF,
    $typeOfPersonBEN,
    $isServiceAccount,
    $consultadeclienteResponse,
    $consultadeclienteResponseBEHALF,
    $consultadeclienteResponseBEN)
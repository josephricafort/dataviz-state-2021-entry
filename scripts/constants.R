#--- CONSTANTS ---#
library(tidyverse)

#--- Main Indicators ---#
# Analysts vs creatives
creative_types <- c("Designer", "Journalist", "Teacher", "Cartographer", # For main dataset
                    "Academic/Teacher", "Student") # For tasktime dataset
analytical_types <- c("Analyst", "Developer", "Scientist", "Engineer", "Leadership (Manager, Director, VP, etc.)")
ambiguous_types <- c("None of these describes my role", "")


# Tools for Dataviz
ToolsForDV_ArcGIS	<-	"ArcGIS"
ToolsForDV_D3	<-	"D3.js"
ToolsForDV_Angular	<-	"Angular"
ToolsForDV_Datawrapper	<-	"Datawrapper"
ToolsForDV_Excel	<-	"Excel"
ToolsForDV_Flourish	<-	"Flourish"
ToolsForDV_ggplot2	<-	"ggplot2"
ToolsForDV_Gephi	<-	"Gephi"
ToolsForDV_GoogleDataStudio	<-	"Google Data Studio"
ToolsForDV_Highcharts	<-	"Highcharts"
ToolsForDV_Illustrator	<-	"Illustrator"
ToolsForDV_Java	<-	"Java"
ToolsForDV_Leaflet	<-	"Leaflet"
ToolsForDV_Mapbox	<-	"Mapbox"
ToolsForDV_KeplerGL	<-	"kepler.gl"
ToolsForDV_Observable	<-	"Observable"
ToolsForDV_Plotly	<-	"Plotly"
ToolsForDV_PowerBI	<-	"Power BI"
ToolsForDV_PowerPoint	<-	"PowerPoint"
ToolsForDV_Python	<-	"Python"
ToolsForDV_QGIS	<-	"QGIS"
ToolsForDV_Qlik	<-	"Qlik"
ToolsForDV_R	<-	"R"
ToolsForDV_React	<-	"React"
ToolsForDV_Tableau	<-	"Tableau"
ToolsForDV_Vega	<-	"Vega"
ToolsForDV_Vue	<-	"Vue"
ToolsForDV_WebComponents	<-	"Web Components"
ToolsForDV_WebGL	<-	"WebGL"
ToolsForDV_PenPaper	<-	"Pen & paper"
ToolsForDV_PhysicalMaterials	<-	"Physical materials (other than pen and paper)"
ToolsForDV_Canvas	<-	"Canvas"
ToolsForDV_P5orProcessing	<-	"P5/Processing"

tools_for_dv_names <- c(
  ToolsForDV_ArcGIS,
  ToolsForDV_D3,
  ToolsForDV_Angular,
  ToolsForDV_Datawrapper,
  ToolsForDV_Excel,
  ToolsForDV_Flourish,	
  ToolsForDV_ggplot2,	
  ToolsForDV_Gephi,	
  ToolsForDV_GoogleDataStudio,	
  ToolsForDV_Highcharts,	
  ToolsForDV_Illustrator,	
  ToolsForDV_Java,	
  ToolsForDV_Leaflet,	
  ToolsForDV_Mapbox,	
  ToolsForDV_KeplerGL,	
  ToolsForDV_Observable,	
  ToolsForDV_Plotly,	
  ToolsForDV_PowerBI,	
  ToolsForDV_PowerPoint,	
  ToolsForDV_Python,	
  ToolsForDV_QGIS,	
  ToolsForDV_Qlik,	
  ToolsForDV_R,	
  ToolsForDV_React,	
  ToolsForDV_Tableau,	
  ToolsForDV_Vega,	
  ToolsForDV_Vue,	
  ToolsForDV_WebComponents,	
  ToolsForDV_WebGL,	
  ToolsForDV_PenPaper,	
  ToolsForDV_PhysicalMaterials,
  ToolsForDV_Canvas,	
  ToolsForDV_P5orProcessing
)

tools_for_dv_vars <- c(
  "ToolsForDV_ArcGIS",
  "ToolsForDV_D3",
  "ToolsForDV_Angular",
  "ToolsForDV_Datawrapper",
  "ToolsForDV_Excel",
  "ToolsForDV_Flourish",	
  "ToolsForDV_ggplot2",	
  "ToolsForDV_Gephi",	
  "ToolsForDV_GoogleDataStudio",	
  "ToolsForDV_Highcharts",	
  "ToolsForDV_Illustrator",	
  "ToolsForDV_Java",	
  "ToolsForDV_Leaflet",	
  "ToolsForDV_Mapbox",	
  "ToolsForDV_KeplerGL",	
  "ToolsForDV_Observable",	
  "ToolsForDV_Plotly",	
  "ToolsForDV_PowerBI",	
  "ToolsForDV_PowerPoint",	
  "ToolsForDV_Python",	
  "ToolsForDV_QGIS",	
  "ToolsForDV_Qlik",	
  "ToolsForDV_R",	
  "ToolsForDV_React",	
  "ToolsForDV_Tableau",	
  "ToolsForDV_Vega",	
  "ToolsForDV_Vue",	
  "ToolsForDV_WebComponents",	
  "ToolsForDV_WebGL",	
  "ToolsForDV_PenPaper",	
  "ToolsForDV_PhysicalMaterials",
  "ToolsForDV_Canvas",	
  "ToolsForDV_P5orProcessing"
)

tools_for_dv_type <- c(
    "mapping",# "ToolsForDV_ArcGIS",
    "web development",# "ToolsForDV_D3",
    "web development",# "ToolsForDV_Angular",
    "data dashboard",# "ToolsForDV_Datawrapper",
    "data processing",# "ToolsForDV_Excel",
    "data dashboard",	# "ToolsForDV_Flourish",	
    "data processing",	# "ToolsForDV_ggplot2",	
    "data dashboard",	# "ToolsForDV_Gephi",	
    "data dashboard",	# "ToolsForDV_GoogleDataStudio",	
    "web development",	# "ToolsForDV_Highcharts",	
    "design",	# "ToolsForDV_Illustrator",	
    "web development",	# "ToolsForDV_Java",	
    "mapping",	# "ToolsForDV_Leaflet",	
    "mapping",	# "ToolsForDV_Mapbox",	
    "web development",	# "ToolsForDV_KeplerGL",	
    "data",	# "ToolsForDV_Observable",	
    "data dashboard",	# "ToolsForDV_Plotly",	
    "data dashboard",	# "ToolsForDV_PowerBI",	
    "design",	# "ToolsForDV_PowerPoint",	
    "data processing",	# "ToolsForDV_Python",	
    "mapping",	# "ToolsForDV_QGIS",	
    "data dashboard",	# "ToolsForDV_Qlik",	
    "data processing",	# "ToolsForDV_R",	
    "web development",	# "ToolsForDV_React",	
    "data dashboard",	# "ToolsForDV_Tableau",	
    "web development",	# "ToolsForDV_Vega",	
    "web development",	# "ToolsForDV_Vue",	
    "web development",	# "ToolsForDV_WebComponents",	
    "web development",	# "ToolsForDV_WebGL",	
    "design",	# "ToolsForDV_PenPaper",	
    "design",# "ToolsForDV_PhysicalMaterials",
    "web development",	# "ToolsForDV_Canvas",	
    "web development"# "ToolsForDV_P5orProcessing"
)

tools_type_lookup <- tibble(tools_for_dv_vars, tools_for_dv_names, tools_for_dv_type) %>%
  mutate(tools_for_dv_type = as.factor(tools_for_dv_type),
         tools_for_dv_names = as.factor(tools_for_dv_names),
         tools_for_dv_type = as.factor(tools_for_dv_type))


# Charts used
ChartsUsed_Line	<-	"Line Chart"
ChartsUsed_Bar	<-	"Bar Chart"
ChartsUsed_PieOrDonut	<-	"Pie Chart/Donut Chart"
ChartsUsed_Scatterplot	<-	"Scatterplot"
ChartsUsed_Histogram	<-	"Histogram"
ChartsUsed_HexbinOrHeatmap	<-	"Hexbin/Heatmap"
ChartsUsed_Infographic	<-	"Infographic"
ChartsUsed_Pictorial	<-	"Pictorial Visualization"
ChartsUsed_Treemap	<-	"Treemap"
ChartsUsed_Dendrogram	<-	"Dendrogram"
ChartsUsed_Network	<-	"Network Diagram"
ChartsUsed_ChoroplethMap	<-	"Choropleth Map"
ChartsUsed_RasterMap	<-	"Raster Map"
ChartsUsed_Waffle	<-	"Waffle Chart"
ChartsUsed_Flow	<-	"Flow Chart (Sankey, DAGRE, Alluvial)"
ChartsUsed_3D	<-	"3D Chart"
ChartsUsed_VRorAR	<-	"VR/AR Chart"
ChartsUsed_BeeSwarm	<-	"Bee Swarm Chart"
ChartsUsed_ForceDirected	<-	"Force-Directed Graph"

charts_used_names <- c(
  ChartsUsed_Line,	
  ChartsUsed_Bar,	
  ChartsUsed_PieOrDonut,	
  ChartsUsed_Scatterplot,	
  ChartsUsed_Histogram,	
  ChartsUsed_HexbinOrHeatmap,	
  ChartsUsed_Infographic,	
  ChartsUsed_Pictorial,	
  ChartsUsed_Treemap,	
  ChartsUsed_Dendrogram,	
  ChartsUsed_Network,	
  ChartsUsed_ChoroplethMap,	
  ChartsUsed_RasterMap,	
  ChartsUsed_Waffle,	
  ChartsUsed_Flow,	
  ChartsUsed_3D,	
  ChartsUsed_VRorAR,	
  ChartsUsed_BeeSwarm,	
  ChartsUsed_ForceDirected
)

charts_used_vars <- c(
  "ChartsUsed_Line" ,	
  "ChartsUsed_Bar" ,	
  "ChartsUsed_PieOrDonut" ,	
  "ChartsUsed_Scatterplot" ,	
  "ChartsUsed_Histogram" ,	
  "ChartsUsed_HexbinOrHeatmap" ,	
  "ChartsUsed_Infographic" ,	
  "ChartsUsed_Pictorial" ,	
  "ChartsUsed_Treemap" ,	
  "ChartsUsed_Dendrogram" ,	
  "ChartsUsed_Network" ,	
  "ChartsUsed_ChoroplethMap" ,	
  "ChartsUsed_RasterMap" ,	
  "ChartsUsed_Waffle" ,	
  "ChartsUsed_Flow" ,	
  "ChartsUsed_3D" ,	
  "ChartsUsed_VRorAR" ,	
  "ChartsUsed_BeeSwarm" ,	
  "ChartsUsed_ForceDirected"
)

# Top frustrations
TopFrustrationsDV_LackTime	<-	"Lack of time"
TopFrustrationsDV_LackDesignExpertise	<-	"Lack of design expertise"
TopFrustrationsDV_LackTechSkill	<-	"Lack of technical skill"
TopFrustrationsDV_LearningNewToolsEtc	<-	"Learning new tools/approaches"
TopFrustrationsDV_AccessingData	<-	"Accessing data"
TopFrustrationsDV_InfoOverload	<-	"Information overload"
TopFrustrationsDV_LackCollaboration	<-	"Lack of collaboration"
TopFrustrationsDV_LackMentorship	<-	"Lack of mentorship"
TopFrustrationsDV_LowDataLiteracy	<-	"Low data literacy"
TopFrustrationsDV_DVNotRespected	<-	"Not enough respect for dataviz"
TopFrustrationsDV_ToolsTechLimits	<-	"Technical limitations of the tools"
TopFrustrationsDV_NonVizActivity	<-	"Too much effort spent on non-viz activity"
TopFrustrationsDV_DataVolume	<-	"Data volume"

top_frustrations_names <- c(
  TopFrustrationsDV_LackTime,	
  TopFrustrationsDV_LackDesignExpertise,
  TopFrustrationsDV_LackTechSkill,
  TopFrustrationsDV_LearningNewToolsEtc,
  TopFrustrationsDV_AccessingData,
  TopFrustrationsDV_InfoOverload,
  TopFrustrationsDV_LackCollaboration,
  TopFrustrationsDV_LackMentorship,
  TopFrustrationsDV_LowDataLiteracy,	
  TopFrustrationsDV_DVNotRespected,
  TopFrustrationsDV_ToolsTechLimits,	
  TopFrustrationsDV_NonVizActivity,
  TopFrustrationsDV_DataVolume
)

top_frustrations_vars <- c(
  "TopFrustrationsDV_LackTime" ,	
  "TopFrustrationsDV_LackDesignExpertise" ,
  "TopFrustrationsDV_LackTechSkill" ,
  "TopFrustrationsDV_LearningNewToolsEtc" ,
  "TopFrustrationsDV_AccessingData" ,
  "TopFrustrationsDV_InfoOverload" ,
  "TopFrustrationsDV_LackCollaboration" ,
  "TopFrustrationsDV_LackMentorship" ,
  "TopFrustrationsDV_LowDataLiteracy" ,	
  "TopFrustrationsDV_DVNotRespected" ,
  "TopFrustrationsDV_ToolsTechLimits" ,	
  "TopFrustrationsDV_NonVizActivity" ,
  "TopFrustrationsDV_DataVolume"
)

top_frustrations_type <- c(
  "productivity", # TopFrustrationsDV_LackTime,	
  "skills & learning", # TopFrustrationsDV_LackDesignExpertise,
  "skills & learning", # TopFrustrationsDV_LackTechSkill,
  "skills & learning", # TopFrustrationsDV_LearningNewToolsEtc,
  "productivity", # TopFrustrationsDV_AccessingData,
  "information", # TopFrustrationsDV_InfoOverload,
  "social", # TopFrustrationsDV_LackCollaboration,
  "skills & learning", # TopFrustrationsDV_LackMentorship,
  "skills & learning", # TopFrustrationsDV_LowDataLiteracy,	
  "social", # TopFrustrationsDV_DVNotRespected,
  "productivity", # TopFrustrationsDV_ToolsTechLimits,	
  "productivity", # TopFrustrationsDV_NonVizActivity,
  "information" # TopFrustrationsDV_DataVolume
)

TopFrustrationsDV_LackTime_Short	<-	"Time"
TopFrustrationsDV_LackDesignExpertise_Short	<-	"Design"
TopFrustrationsDV_LackTechSkill_Short	<-	"Tech skill"
TopFrustrationsDV_LearningNewToolsEtc_Short	<-	"New tools"
TopFrustrationsDV_AccessingData_Short	<-	"Data access"
TopFrustrationsDV_InfoOverload_Short	<-	"Info overload"
TopFrustrationsDV_LackCollaboration_Short	<-	"Collab"
TopFrustrationsDV_LackMentorship_Short	<-	"Mentorship"
TopFrustrationsDV_LowDataLiteracy_Short	<-	"Data literacy"
TopFrustrationsDV_DVNotRespected_Short	<-	"Respect DV"
TopFrustrationsDV_ToolsTechLimits_Short	<-	"Tech tools limits"
TopFrustrationsDV_NonVizActivity_Short	<-	"Non-viz activity"
TopFrustrationsDV_DataVolume_Short	<-	"Data volume"

top_frustrations_short <- c (
  TopFrustrationsDV_LackTime_Short,
  TopFrustrationsDV_LackDesignExpertise_Short,
  TopFrustrationsDV_LackTechSkill_Short,
  TopFrustrationsDV_LearningNewToolsEtc_Short,
  TopFrustrationsDV_AccessingData_Short,
  TopFrustrationsDV_InfoOverload_Short,
  TopFrustrationsDV_LackCollaboration_Short,
  TopFrustrationsDV_LackMentorship_Short,
  TopFrustrationsDV_LowDataLiteracy_Short,
  TopFrustrationsDV_DVNotRespected_Short,
  TopFrustrationsDV_ToolsTechLimits_Short,
  TopFrustrationsDV_NonVizActivity_Short,
  TopFrustrationsDV_DataVolume_Short
)

top_frust_lookup <- tibble(top_frustrations_names, 
                           top_frustrations_vars,
                           top_frustrations_type,
                           top_frustrations_short) %>%
  mutate(top_frustrations_names = as.factor(top_frustrations_names),
         top_frustrations_vars = as.factor(top_frustrations_vars),
         top_frustrations_type = as.factor(top_frustrations_type),
         top_frustrations_short = as.factor(top_frustrations_short)) 

# Top Issues
TopIssuesDV_LackAwarenessOfDVImpact	<-	'Lack of awareness of the impact of dataviz'
TopIssuesDV_NoSeatAtTableForDV	<-	'Data visualization not having a “seat at the table”'
TopIssuesDV_DiversityInTech	<-	'Diversity in tech'
TopIssuesDV_IncomeInequality	<-	'Income inequality'
TopIssuesDV_LackDVLiteracy	<-	'Lack of data visualization literacy'
TopIssuesDV_DesignForDisabilities	<-	'Designing for disabilities'
TopIssuesDV_LackEducationAccess	<-	'Lack of access to education'
TopIssuesDV_AlgorithmicBias	<-	'Algorithmic bias' 
TopIssuesDV_LackEthicalStandards <-	'Lack of ethical standards for visualizing data'
TopIssuesDV_LackSoftwareLiteracy <-	'Lack of software literacy'

top_issues_names <- c(
  TopIssuesDV_LackAwarenessOfDVImpact,
  TopIssuesDV_NoSeatAtTableForDV,
  TopIssuesDV_DiversityInTech,
  TopIssuesDV_IncomeInequality,
  TopIssuesDV_LackDVLiteracy,
  TopIssuesDV_DesignForDisabilities,
  TopIssuesDV_LackEducationAccess,
  TopIssuesDV_AlgorithmicBias,
  TopIssuesDV_LackEthicalStandards,
  TopIssuesDV_LackSoftwareLiteracy
)

top_issues_vars <- c(
  "TopIssuesDV_LackAwarenessOfDVImpact",
  "TopIssuesDV_NoSeatAtTableForDV",
  "TopIssuesDV_DiversityInTech",
  "TopIssuesDV_IncomeInequality",
  "TopIssuesDV_LackDVLiteracy",
  "TopIssuesDV_DesignForDisabilities",
  "TopIssuesDV_LackEducationAccess",
  "TopIssuesDV_AlgorithmicBias",
  "TopIssuesDV_LackEthicalStandards",
  "TopIssuesDV_LackSoftwareLiteracy"
)

top_issues_type <- c(
  "dv-specific", # TopIssuesDV_LackAwarenessOfDVImpact,
  "dv-specific", # TopIssuesDV_NoSeatAtTableForDV,
  "socio-economic", # TopIssuesDV_DiversityInTech,
  "socio-economic", # TopIssuesDV_IncomeInequality,
  "education", # TopIssuesDV_LackDVLiteracy,
  "socio-economic", # TopIssuesDV_DesignForDisabilities,
  "education", # TopIssuesDV_LackEducationAccess,
  "socio-economic", # TopIssuesDV_AlgorithmicBias,
  "socio-economic", # TopIssuesDV_LackEthicalStandards,
  "education" # TopIssuesDV_LackSoftwareLiteracy
)

top_issues_lookup <- tibble(top_issues_vars, 
                            top_issues_names,
                            top_issues_type) %>%
  mutate(top_issues_vars <- as.factor(top_issues_vars),
         top_issues_names <- as.factor(top_issues_names),
         top_issues_type = as.factor(top_issues_type))

# Org sector
OrgSector_Journalism	<-	"Journalism"
OrgSector_Public	<-	"Public sector (government)"
OrgSector_Private	<-	"Private sector"
OrgSector_Nonprofit	<-	"Non-profit"
OrgSector_HealthMed	<-	"Healthcare/medical"
OrgSector_IT	<-	"Information technology"
OrgSector_Marketing	<-	"Marketing"
OrgSector_Finance	<-	"Finance"
OrgSector_Academia	<-	"Academia"
OrgSector_ConsultantMulti	<-	"Consultant (therefore multiple areas)"

org_sector_names <- c(
  OrgSector_Journalism,
  OrgSector_Public,
  OrgSector_Private,
  OrgSector_Nonprofit,
  OrgSector_HealthMed,
  OrgSector_IT,
  OrgSector_Marketing,
  OrgSector_Finance,
  OrgSector_Academia,
  OrgSector_ConsultantMulti
)

org_sector_vars <- c(
  "OrgSector_Journalism",
  "OrgSector_Public",
  "OrgSector_Private",
  "OrgSector_Nonprofit",
  "OrgSector_HealthMed",
  "OrgSector_IT",
  "OrgSector_Marketing",
  "OrgSector_Finance",
  "OrgSector_Academia",
  "OrgSector_ConsultantMulti"
)

org_sector_category <- c(
  "industry", # OrgSector_Journalism,
  "affiliation", # OrgSector_Public,
  "affiliation", # OrgSector_Private,
  "affiliation", # OrgSector_Nonprofit,
  "industry", # OrgSector_HealthMed,
  "industry", # OrgSector_IT,
  "industry", # OrgSector_Marketing,
  "industry", # OrgSector_Finance,
  "industry", # OrgSector_Academia,
  "multi-industry" # OrgSector_ConsultantMulti
)

org_sector_lookup <- tibble(org_sector_names, 
                            org_sector_vars, 
                            org_sector_category) %>%
  mutate(org_sector_names = as.factor(org_sector_names),
         org_sector_vars = as.factor(org_sector_vars),
         org_sector_category = as.factor(org_sector_category))


# Persona Name
persona_names <- c(
  "The Analyst Intern",
  "The Senior BI Analyst",
  "The Professor",
  "The Hackathon-er",
  "The Business Analyst",
  "The Data Journalist",
  "The ML Consultant",
  "The Gov. Statistician",
  "The Infographics Geek",
  "The Graphics Editor",
  "The Science Illustrator",
  "The Tableau Champ",
  "The Creative Coder",
  "The Studio Founder",
  "The Tech Pioneer",
  "The Generative Artist"
)

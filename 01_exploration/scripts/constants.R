#--- CONSTANTS ---#

# Tools for Dataviz
ToolsForDV_ArcGIS	=	"ArcGIS"
ToolsForDV_D3	=	"D3.js"
ToolsForDV_Angular	=	"Angular"
ToolsForDV_Datawrapper	=	"Datawrapper"
ToolsForDV_Excel	=	"Excel"
ToolsForDV_Flourish	=	"Flourish"
ToolsForDV_ggplot2	=	"ggplot2"
ToolsForDV_Gephi	=	"Gephi"
ToolsForDV_GoogleDataStudio	=	"Google Data Studio"
ToolsForDV_Highcharts	=	"Highcharts"
ToolsForDV_Illustrator	=	"Illustrator"
ToolsForDV_Java	=	"Java"
ToolsForDV_Leaflet	=	"Leaflet"
ToolsForDV_Mapbox	=	"Mapbox"
ToolsForDV_KeplerGL	=	"kepler.gl"
ToolsForDV_Observable	=	"Observable"
ToolsForDV_Plotly	=	"Plotly"
ToolsForDV_PowerBI	=	"Power BI"
ToolsForDV_PowerPoint	=	"PowerPoint"
ToolsForDV_Python	=	"Python"
ToolsForDV_QGIS	=	"QGIS"
ToolsForDV_Qlik	=	"Qlik"
ToolsForDV_R	=	"R"
ToolsForDV_React	=	"React"
ToolsForDV_Tableau	=	"Tableau"
ToolsForDV_Vega	=	"Vega"
ToolsForDV_Vue	=	"Vue"
ToolsForDV_WebComponents	=	"Web Components"
ToolsForDV_WebGL	=	"WebGL"
ToolsForDV_PenPaper	=	"Pen & paper"
ToolsForDV_PhysicalMaterials	=	"Physical materials (other than pen and paper)"
ToolsForDV_Canvas	=	"Canvas"
ToolsForDV_P5orProcessing	=	"P5/Processing"

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

# Charts used
ChartsUsed_Line	=	"Line Chart"
ChartsUsed_Bar	=	"Bar Chart"
ChartsUsed_PieOrDonut	=	"Pie Chart/Donut Chart"
ChartsUsed_Scatterplot	=	"Scatterplot"
ChartsUsed_Histogram	=	"Histogram"
ChartsUsed_HexbinOrHeatmap	=	"Hexbin/Heatmap"
ChartsUsed_Infographic	=	"Infographic"
ChartsUsed_Pictorial	=	"Pictorial Visualization"
ChartsUsed_Treemap	=	"Treemap"
ChartsUsed_Dendrogram	=	"Dendrogram"
ChartsUsed_Network	=	"Network Diagram"
ChartsUsed_ChoroplethMap	=	"Choropleth Map"
ChartsUsed_RasterMap	=	"Raster Map"
ChartsUsed_Waffle	=	"Waffle Chart"
ChartsUsed_Flow	=	"Flow Chart (Sankey, DAGRE, Alluvial)"
ChartsUsed_3D	=	"3D Chart"
ChartsUsed_VRorAR	=	"VR/AR Chart"
ChartsUsed_BeeSwarm	=	"Bee Swarm Chart"
ChartsUsed_ForceDirected	=	"Force-Directed Graph"

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
TopFrustrationsDV_LackTime	=	"Lack of time"
TopFrustrationsDV_LackDesignExpertise	=	"Lack of design expertise"
TopFrustrationsDV_LackTechSkill	=	"Lack of technical skill"
TopFrustrationsDV_LearningNewToolsEtc	=	"Learning new tools/approaches"
TopFrustrationsDV_AccessingData	=	"Accessing data"
TopFrustrationsDV_InfoOverload	=	"Information overload"
TopFrustrationsDV_LackCollaboration	=	"Lack of collaboration"
TopFrustrationsDV_LackMentorship	=	"Lack of mentorship"
TopFrustrationsDV_LowDataLiteracy	=	"Low data literacy"
TopFrustrationsDV_DVNotRespected	=	"Not enough respect for dataviz"
TopFrustrationsDV_ToolsTechLimits	=	"Technical limitations of the tools"
TopFrustrationsDV_NonVizActivity	=	"Too much effort spent on non-viz activity"
TopFrustrationsDV_DataVolume	=	"Data volume"

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

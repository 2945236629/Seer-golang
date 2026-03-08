package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.display.MovieClip;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_10775 extends BaseMapProcess
   {
      
      private var _mc:MovieClip;
      
      private var _monsterIds:Array = [1768,1364,1697,966,667,203,775,941,1344,1509,746];
      
      private var _bossIds:Array = [2865,2866,2867,2868,2869,2870,2871,2872,2873,2874,2875];
      
      private var _bossNames:Array = ["该洛林","艾里克","辛基德","哈罗威","普顿","晶岩兽","粉粉","维克","小咕","小超灵","基鲁"];
      
      private var _powerGoodX:Array = [150,370,550,750];
      
      private var _powerGoodY:Array = [300,420,270,100];
      
      private var _getPowerGoodsNum:uint = 0;
      
      private var _fightBossSeq:uint = 0;
      
      private var _specialType:uint = 0;
      
      public function MapProcess_10775()
      {
         super();
      }
      
      override protected function init() : void
      {
         getDefinitionByName("com.robot.app2.control.SearchRareMonsterController").initForMap(this);
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.control.SearchRareMonsterController").destroy();
         super.destroy();
      }
   }
}


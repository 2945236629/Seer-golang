package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.BitBuffSetClass;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.display.MovieClip;
   import flash.utils.getDefinitionByName;
   import org.taomee.manager.ResourceManager;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcess_1024 extends BaseMapProcess
   {
      
      public function MapProcess_1024()
      {
         super();
      }
      
      override protected function init() : void
      {
         this.playAnimate();
      }
      
      private function playAnimate() : void
      {
         var bitCode:int = 0;
         bitCode = 22550;
         if(!BitBuffSetClass.getState(bitCode))
         {
            ResourceManager.getResource(ClientConfig.getMapAnimate("map_1024_0"),function(param1:MovieClip):void
            {
               var mc:MovieClip = param1;
               conLevel.addChild(mc);
               getDefinitionByName("com.robot.app2.systems.mapObject.MapObjectControl").hideOrShowAllObjects(false);
               KTool.hideMapAllPlayerAndMonster();
               AnimateManager.playMcAnimate(mc,1,"mc",function():void
               {
                  BitBuffSetClass.setState(bitCode,1);
                  DisplayUtil.removeForParent(mc);
                  getDefinitionByName("com.robot.app2.systems.mapObject.MapObjectControl").hideOrShowAllObjects(true);
                  KTool.showMapAllPlayerAndMonster();
               });
            });
         }
      }
      
      override public function destroy() : void
      {
      }
   }
}


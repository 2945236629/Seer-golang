package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.BitBuffSetClass;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.manager.ResourceManager;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcess_10611 extends BaseMapProcess
   {
      
      public function MapProcess_10611()
      {
         super();
      }
      
      override protected function init() : void
      {
         MovieClip(btnLevel["pet_1"]).buttonMode = true;
         MovieClip(btnLevel["pet_1"]).addEventListener(MouseEvent.CLICK,this.onClickPet);
         StatManager.sendStat2014("冥帝修罗","成功进入10611号场景",StatManager.RUN_ACT);
      }
      
      private function playAnim() : void
      {
         ResourceManager.getResource(ClientConfig.getMapAnimate("map_1030_2"),function(param1:MovieClip):void
         {
            var mc:MovieClip = param1;
            LevelManager.appLevel.addChild(mc);
            btnLevel.visible = false;
            KTool.hideMapAllPlayerAndMonster();
            AnimateManager.playMcAnimate(mc,1,"mc",function():void
            {
               DisplayUtil.removeForParent(mc);
               btnLevel.visible = true;
               KTool.showMapAllPlayerAndMonster();
               BitBuffSetClass.setState(22532,1,function():void
               {
                  ModuleManager.showModule(ClientConfig.getAppModule("SealSorensenPanel"));
               });
            });
         });
      }
      
      protected function onClickPet(param1:MouseEvent) : void
      {
         if(BitBuffSetClass.getState(22532))
         {
            ModuleManager.showModule(ClientConfig.getAppModule("SealSorensenPanel"),"正在打开");
         }
         else
         {
            this.playAnim();
         }
      }
      
      override public function destroy() : void
      {
         MovieClip(btnLevel["pet_1"]).removeEventListener(MouseEvent.CLICK,this.onClickPet);
         super.destroy();
      }
   }
}


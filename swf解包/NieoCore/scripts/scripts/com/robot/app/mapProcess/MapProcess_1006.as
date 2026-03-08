package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.BitBuffSetClass;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcess_1006 extends BaseMapProcess
   {
      
      private var sptMC:MovieClip;
      
      public function MapProcess_1006()
      {
         super();
      }
      
      override protected function init() : void
      {
         this.sptMC = conLevel["sptMC"];
         this.sptMC.mouseChildren = false;
         this.sptMC.buttonMode = true;
         this.sptMC.addEventListener(MouseEvent.CLICK,this.onFight);
         if(BitBuffSetClass.getState(22526) == 0)
         {
            BitBuffSetClass.setState(22526,1);
            LevelManager.toolsLevel.visible = false;
            LevelManager.iconLevel.visible = false;
            KTool.showMapAllPlayerAndMonster(false);
            AnimateManager.playMcAnimate(this.sptMC,0,"",function():void
            {
               LevelManager.toolsLevel.visible = true;
               LevelManager.iconLevel.visible = true;
               KTool.showMapAllPlayerAndMonster(true);
            });
         }
         else
         {
            this.sptMC.gotoAndStop(this.sptMC.totalFrames);
         }
      }
      
      private function onFight(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         NpcDialog.show(NPC.DOUMO,["好饿啊，新鲜的肉来了！你愿意成为我的食物吗？"],["去死吧，胖子！","我还是躲远一点吧！"],[function():void
         {
            FightManager.fightWithBoss("斗魔旺乔",0);
         }]);
      }
      
      override public function destroy() : void
      {
         this.sptMC.removeEventListener(MouseEvent.CLICK,this.onFight);
         this.sptMC = null;
      }
   }
}

